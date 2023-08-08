Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3A774CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjHHVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjHHVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:13:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D91473FC;
        Tue,  8 Aug 2023 12:43:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so51337415e9.0;
        Tue, 08 Aug 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691523783; x=1692128583;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOolvKmjNbA3psrGMAp+3ipqqGdZ/BVnezDxpZWH8ms=;
        b=HC9tZ1QtSi5ORdON+XMHnl2vCZ6cJogJ8xaGHcBU0vDyWWpj9nX+I8TxYJ0iBuqeAs
         0KjHFKewwDIkng9wdW7Z9W0q7murFn3rqAHU9n40ahS3m5Hga3FlZsa7aN2hSziKE/E+
         ielv5q6faWE7fRi0aovuTUAEGAIKaByelW2Lq6b4BxJEIhJpqlNBiW4+ng7uJnh5dLLe
         njufyxgs9w+y/4MCEWbhprLvcQz71kzfXI7og601cU7QmPGzzgW/XaT6K8JJ5TF7nvu+
         epUjRvgm6+00D2argBvHWJrLPUrdlfJay1W8CMfmaMkrSwzqWksI7/X5rXM+iccb2ost
         gSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691523783; x=1692128583;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOolvKmjNbA3psrGMAp+3ipqqGdZ/BVnezDxpZWH8ms=;
        b=KxsJ2B0lWadLiGFNzEqiRk16J77/MUCspbg9wiVtCFom6b2EO0bra8eLodvNySQfv8
         8IwXh1RY07oLX0uUvYlFRlk/A85UUqhs4Rn/HGOxnzPOEiLIo7ug/AumgRH8tjzVGUTk
         yfn0Xb1mRZr9J/1PlqF9CbaJfpQhIoj1HdkdQ9kaSjZJ3mm1WfhT9UXpu0rouE5F/ixC
         kcM/N1+ByQ5jQTDdLe+mJIsmgpiyjvQA2Bpmnu0moXaaR8vb+JjhGW3QLOMiBjETZ1ML
         t+Z3tpWEdQVyJJGq5XXLRXJnm23ABbEHVRV783TZATkQbUgxHRw0SvF2Qz18xZ1ZQv8L
         9aSA==
X-Gm-Message-State: AOJu0Yyuvx428Y3PthND87Le/PED1kFypy3b76GHWZ+bkzlbN0BIdjqm
        9KV8qThJrPWbs3XQOXRRuEpsd/3OtMK6nlIkVB8=
X-Google-Smtp-Source: AGHT+IH63RiCGVaJ+XGcErXY3rfQFL9fz6CdslQk4F3i+XRxMUcLBRkelsoaCKiCvoxb6Qp1HbLTJw==
X-Received: by 2002:a05:600c:2215:b0:3fc:5a3:367c with SMTP id z21-20020a05600c221500b003fc05a3367cmr621098wml.32.1691523783245;
        Tue, 08 Aug 2023 12:43:03 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:15aa:8c5a:b813:cec2:4273])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b003fbfef555d2sm19090487wmj.23.2023.08.08.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:43:02 -0700 (PDT)
Date:   Tue, 8 Aug 2023 23:42:58 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     mickflemm@gmail.com, mcgrof@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        mahmoudmatook.mm@gmail.com
Subject: Re: [PATCH] ath5k: fix WARNING opportunity for swap.
Message-ID: <20230808194258.ocxnmqwzqlr6jpe4@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: Jiri Slaby <jirislaby@kernel.org>, mickflemm@gmail.com,
        mcgrof@kernel.org, kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
 <92a26f67-1b24-ea35-2f39-7c0b75027617@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a26f67-1b24-ea35-2f39-7c0b75027617@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08, Jiri Slaby wrote:

> On 07. 08. 23, 22:10, Mahmoud Maatuq wrote:
> > coccinielle reported the following:
> > ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()
> 
> 
> OK, once again:
> https://lore.kernel.org/all/0c3acbd4-6ab2-5cc5-6293-54e30093cce2@kernel.org/


I had a look at the commit history, to see why the original developer 
didn't use sort() function, and name the array variable sort but found
nothing. 
I have some doubts that he might did that intentionally, so not to call
sort() function for such small array and avoid the cost of context
switching.


> > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > ---
> >   drivers/net/wireless/ath/ath5k/phy.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
> > index 5797ef9c73d7..f87eb684f223 100644
> > --- a/drivers/net/wireless/ath/ath5k/phy.c
> > +++ b/drivers/net/wireless/ath/ath5k/phy.c
> > @@ -1562,16 +1562,13 @@ static s16
> >   ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
> >   {
> >   	s16 sort[ATH5K_NF_CAL_HIST_MAX];
> > -	s16 tmp;
> >   	int i, j;
> >   	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
> >   	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
> >   		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
> >   			if (sort[j] > sort[j - 1]) {
> > -				tmp = sort[j];
> > -				sort[j] = sort[j - 1];
> > -				sort[j - 1] = tmp;
> > +				swap(sort[j], sort[j - 1]);
> >   			}
> >   		}
> >   	}
> 
> -- 
> js
> suse labs
