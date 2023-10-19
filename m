Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29B67CFEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbjJSP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjJSP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:58:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F7106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:58:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b709048d8eso4738589b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731102; x=1698335902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HkHJ/8jn2JaOF0xO0UppYJ9aqH2RJuNpshWIljvl7w=;
        b=lhHsLd65A/nEEjFTFAze4LDpoRQyj5ThgmU0iUwU0zicV6g35KJh4L0lb+YTYJGAwb
         fwR+a6c1jtBQ0AIEIvcp0+AxtbwWD3N2rdMGqWHDT+Mo8dB9X/MOGJll8srNdAc6O4Ty
         5fyW4tabCJ/MKKxsbrfGdWPz0U7o6ux3BoyrxzenLuabk7f2qgpi4jEwpSWaSVDkouxM
         96RZWVWy0LbZGc4p4cN4FUaeADPvsZqkMQtjQbj3TF9Tsm5RjnEuokgrqPrmf9fn0kx8
         eMz6CRNdQaaWlMZygn9lLm0y4KSogVdDkKXdC746wi9SX+OwvHOm76h5ZsDDkOQd9LWt
         0fzQ==
X-Gm-Message-State: AOJu0Yz4xEXGOVHU1Vwq6S5i2btyp7BbRRHtah5IY0eM5+qKM8CzylQ1
        2VR1fUzH/snPqlDd/Uuw6+Q=
X-Google-Smtp-Source: AGHT+IFbcwL8YPhXgfA4W2vECzu+u6WZn5lBg2HAq0L3cmYhQ7QhOkS02frRF/Lod55u5Zb2RwZvZA==
X-Received: by 2002:a05:6a21:35c4:b0:174:52b7:f63 with SMTP id ba4-20020a056a2135c400b0017452b70f63mr2506957pzc.26.1697731101527;
        Thu, 19 Oct 2023 08:58:21 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b0026801e06ac1sm1897920pjc.30.2023.10.19.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:58:20 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:58:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697731096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HkHJ/8jn2JaOF0xO0UppYJ9aqH2RJuNpshWIljvl7w=;
        b=StJU++p7NDaYYEnkeqTs+2D31flndIsU9T60N062eZKw/jes9r05JvNRPl/Eq1UDxzDJt/
        vrhvrj1WcOFA40mTS7TGAxQXPwg884I+L+PBIk3H999B0jAhjbcAQU7C6GWc8RztlSEuOP
        MwXAU2hKIjLhMnEel0coubYKf6SqL3k8s7hURHc0ePPNLO1k5xBDmcqiS+h2vv4/p8TUzy
        6YRzLHAEkqceplw3KyHGNxLirec6yWEpv3szPsXZW6QNV2IpBa8B03Z7TrQ6iEldqiNHmV
        ZbvxdQtkr64rjioEBXSEYd209cC4XgRN4rY/zHoVZKaU27l+m+uvbUZlCYpcuw==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Calvince Otieno <calvncce@gmail.com>, gustavo@embeddedor.com,
        outreachy@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Message-ID: <yj7xx2g3b3jmuxuvqotum3gyekd64lbrgjz42kafy77gu3n34e@zibkzqy4d4tu>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
 <qqvbqinun7wbhaz47i6sk2awplknwbrfutrwfpvj6wq4wgdie6@smhzxank6val>
 <2023101908-bouncy-dandelion-da1e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101908-bouncy-dandelion-da1e@gregkh>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/19 05:29PM, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 09:50:07AM -0300, Ricardo B. Marliere wrote:
> > Hey there,
> > 
> > just as a heads up, the vc04_services staging drivers seem to be
> > actively developed elsewhere [1]. I'm not sure how they plan to upstream
> > their code later.
> 
> They are being actively developed here, one the staging list, whatever
> out-of-tree stuff will come after all of the required fixes and cleanups
> will get merged here and then the out-of-tree stuff can be added later.
> 
> So no need to worry about random github trees please.

That is good to know, thanks for the clarification!

-	Ricardo
