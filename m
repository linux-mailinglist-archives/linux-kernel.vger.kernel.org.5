Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D427B3290
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjI2Mau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjI2Mat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:30:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3C1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:30:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5031ccf004cso22234172e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695990644; x=1696595444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D6U3h7VvtySfjwCrXv2bKuHA6TCTGNwEjt2Sm81uJI=;
        b=PvGhUEWAMTx6/EQ83rQk2Wznq66kHeFJnoCXpQjCRbYFGa6wRT5KzuUsNF7XANgWr4
         gTqot8OzzU/+4bEAYcRP+LKQ0SdM21xA1a+2T4cI6nhGWoV/KBmKjvTEjvvcJZJs8nVE
         hoBKPOYk/2XktF/WqiA/LxTqeL4sQ9E45LaP37ELq84UzTNWV9v9k1jCpnLOGT0KBUkC
         EtX1hseIO8XsFe7CrgH5Kmz3DMT0EmbakVM2fzkognDN9aVuDq4HMarM5zo7TpRksnZl
         Btcw78BpLoTdr36PAON3kC859bAYBaKurmuBWddlLVHbegiyAM09Aj38Tm6n4nkrRXx3
         GP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990644; x=1696595444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D6U3h7VvtySfjwCrXv2bKuHA6TCTGNwEjt2Sm81uJI=;
        b=SCft9HMjrA0WtZI42WqjdCkN0sdlTib5pB8H5QIL6QC2reX+LJZNHh0hkz88rngmdg
         00RjB3PeI0EMWhSe9uA9VpDokc8e4IP24M4/eVj30inALlc4H3eqcsEnSAUl3sCG44Z1
         jqJ8yfVsotJOWkcg3C31AzmYgvq6I5Ilmy59cU43Ujyx6Euwc1fUPPEnj62JlP/CxBAQ
         SCZ/QqvIhalnGm/XgC9Fu3WNsXveKF0m3BcS90OOuOsZT1HSny1AKSkcl8ZNClMN4N+0
         PEzh/U+2ftO81A494o1cu8nl3LO/WKjv/Hb1+5J4ekmfYWlxhXKEdXceVduMvWJ3lkqh
         5n9Q==
X-Gm-Message-State: AOJu0Yw1CA18SSS9tAVRZ3LNTm6OYYhCjOl7Hmr4XN0ZSdwDjyhHDKI/
        4m7UanMpoaSe5RjUivJLMtIcTg==
X-Google-Smtp-Source: AGHT+IG35Lyp3ifL3xVwb3OmKh0JKsFL2ah9iqCExGP1+exCUUTXAWhW83gBYHeI8P6flItc65Kebw==
X-Received: by 2002:a05:6512:6c7:b0:504:7e12:4846 with SMTP id u7-20020a05651206c700b005047e124846mr3991988lff.30.1695990643555;
        Fri, 29 Sep 2023 05:30:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm13431260wrb.106.2023.09.29.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:30:43 -0700 (PDT)
Date:   Fri, 29 Sep 2023 15:30:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christian Lamparter <chunkeey@gmail.com>,
        Shiji Yang <yangshiji66@qq.com>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Wu Yunchuan <yunchuan@nfschina.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary
 (void*) conversions
Message-ID: <f2e567f3-97ff-494a-b25c-b5d12652b034@kadam.mountain>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
 <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
 <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
 <c5611be9-ef4d-4e49-84de-7ce893e3c73c@gmail.com>
 <721a4c53-a253-4b0e-a5e0-fc4b992feb49@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721a4c53-a253-4b0e-a5e0-fc4b992feb49@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:26:17PM +0300, Dan Carpenter wrote:
> On Fri, Sep 29, 2023 at 09:23:26AM +0200, Christian Lamparter wrote:
> > I would like to take the chance to again point to this beauty:
> > <https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541>
> > @Dan, @Jeff can you please comment on that too?
> 
> I don't know how Shiji Yang generated this warning.  The warning doesn't
> make sense and I don't see how the patch helps.  I tested with GCC (v12)
> and Clang (random from git) and neither one generates a warning.  What's
> the point of having all the struct members in a group when struct itself
> already forms a group?
> 
> #confused

Wait, all this was in the email thread from June but I didn't scroll
down beyond the end of the patch...  It was just a compiler bug in a
GCC dot release.

regards,
dan carpenter

