Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A27B3285
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjI2M02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjI2M0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:26:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411971B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:26:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso12172294f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695990380; x=1696595180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOwsmdvaqsnWOGdKfDU1+n+TMnPog80u/xFpJeYRDeI=;
        b=KR5/WRfE8CiflZyoeNSa5QQ2VMG0mRUZILilNdOYVJRVZQM3BZB8yMD4H9NvC+LLKA
         AllETZlhyBRETV9GtraiHcPgBiqK2W+WdkViEPogKZHWdpkQZSMdA0Oi0yP4holTzuOe
         izunGc8rPEc67ru2yD/Lqh53SYlQOoWmHtThxfZllnaiz3BsN3OVnFWm95c5XFS8PbAr
         48fQVNpaIXCHn4Oi3D/Z1q82olGM02po/8yvzezuz+wUYjY3kc8w/uGNiqf7C9y2MX4E
         o7ZQKgvM1Ka9WA7X7XHwWb0LpByQ39EQibzLI4Yr1LmDcPeX16b4Brxjj47kjWLqDxmT
         0KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990380; x=1696595180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOwsmdvaqsnWOGdKfDU1+n+TMnPog80u/xFpJeYRDeI=;
        b=VdOzy5lFltooUW1/SXaBhcsYuyh/G4mivHoVoQMNYWUPVy0eEC+myhkYyY/HDNYcgS
         aZruQv8bJKDlECisxgY0FIvwtg7MsuuX/FC7t25SjWyFeYcO6Dy2RLlyqLg+UiideTpu
         uvs/JGcL+eB4rmsJjGiQLokmDIGZrBMEhxMztYpGIPBtCCV/aP4aWlOjfdPEGs5cqN5d
         mzC28Rd3VUVSQnFEnlcG0MSycdUK2HZsm4Tu6UVlzGc4sWPGzRcVqK6zBtUqRXGcUgCW
         4WqvbxYGe4hW12hkezjcFxEDGK/gZS7Vm9JpZIahYKKYZ2LvMfYcqGzsIg76BnkHhInJ
         fIzg==
X-Gm-Message-State: AOJu0YzlRDXpwed8ZG/nOe93F89zD1iyLhBrDn1SOcIfnUd3mQOZHxZ+
        nLYa6FTspq8iAyLW6Gs4l5zm6g==
X-Google-Smtp-Source: AGHT+IFUoMj9nVwl6ZieDh3TdJZjzxLVhrxNXo1sk7Mp1DTcFzfqJjOkIJHYQ+0I05t0svf4UpsJyg==
X-Received: by 2002:a5d:62c6:0:b0:31f:b138:5a0 with SMTP id o6-20020a5d62c6000000b0031fb13805a0mr3305014wrv.48.1695990380575;
        Fri, 29 Sep 2023 05:26:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k8-20020adfe3c8000000b00326028b4dd5sm571889wrm.113.2023.09.29.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:26:19 -0700 (PDT)
Date:   Fri, 29 Sep 2023 15:26:17 +0300
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
Message-ID: <721a4c53-a253-4b0e-a5e0-fc4b992feb49@kadam.mountain>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
 <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
 <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
 <c5611be9-ef4d-4e49-84de-7ce893e3c73c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5611be9-ef4d-4e49-84de-7ce893e3c73c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:23:26AM +0200, Christian Lamparter wrote:
> I would like to take the chance to again point to this beauty:
> <https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541>
> @Dan, @Jeff can you please comment on that too?

I don't know how Shiji Yang generated this warning.  The warning doesn't
make sense and I don't see how the patch helps.  I tested with GCC (v12)
and Clang (random from git) and neither one generates a warning.  What's
the point of having all the struct members in a group when struct itself
already forms a group?

#confused

regards,
dan carpenter

