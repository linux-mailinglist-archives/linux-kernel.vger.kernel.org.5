Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556977A868B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjITOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjITO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:29:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2538B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:29:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502a4f33440so11374795e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695220190; x=1695824990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysWSXqnK8OeEpLhbUCktYsznOSRQAjBgSh+YG4ngKDI=;
        b=W5GiZ2cSHAdw4iz253T0vJfUvH8mS3j2LGdbybr2qPe/fMRKR3MhkJO2BYrPI4RNgc
         0e3h01weDnjiQ8YhOWc0O1j7fxBRiuTSlOnX/wwk59eMW52BpTkn/w0/xZSpVSeF8JYf
         Fe8wWHDDOgEHz49LoHvkPZM67NUplqmqswH/mC7a/9GPEl44KMJFHDlpsMiHmtblPMxb
         CK66fw5JcXNdcbWQw2jYBxQkDjGuubBNt3352AYB5wPkGCU3lHzpb2hCmW875DoOb5FQ
         CVJAIorSaanqsQ58RwFmeWdDR7F6uDbdwUj6AjMddbI0svIkuDncniQzcxReof0S5po2
         YTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220190; x=1695824990;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysWSXqnK8OeEpLhbUCktYsznOSRQAjBgSh+YG4ngKDI=;
        b=AqNAxQLyG2ltgR/zfOh+AzfnkeBKmPUPR8NNnb1veYF931Npm7wueXRPjUziR4iOrJ
         Cego2BjX89RKYeW8wo76PnmG+tUH2b2rLhLlsHY2WA712ohop8m0NhKMSxPLfwqoFUs6
         AJxE7F57oxpWnFIlE6G9RPnxud3hSmzKcbbCzWj+1Tx5ILgAdyu0ifCTOq3XqCN1/LJp
         AbWcG/hDJ/mrJaA/PGdXs1AlrXAsKuzM52YQsF9INB3SKzZo00cj5+L4B2ogkOsMgwAn
         XWog0hQvpEIpdvVX5xQMuHJfwiSvI+PIz9f32qpWVgLJV6vPxueJIazltrfJbY3N4w0E
         fRzQ==
X-Gm-Message-State: AOJu0Yyg+qGb7+jct5obI9S5FbOTAL6dReX8MQk9Wo0HoCGYi3YMkOhF
        OV7lh3uNIYCnfRO2dRQZsg4=
X-Google-Smtp-Source: AGHT+IF4292rSmWZUTEL97qdL/H5LRRTmvg/tMETf2isHSAXVL8Pq0PSKunSu55P6aWx1bPL8l1Jzg==
X-Received: by 2002:a05:6512:445:b0:503:3707:66ed with SMTP id y5-20020a056512044500b00503370766edmr2230433lfk.34.1695220189426;
        Wed, 20 Sep 2023 07:29:49 -0700 (PDT)
Received: from akanner-r14. ([91.245.138.112])
        by smtp.gmail.com with ESMTPSA id j14-20020ac2550e000000b004fe2de20d88sm2670935lfk.232.2023.09.20.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:29:48 -0700 (PDT)
Message-ID: <650b01dc.c20a0220.51a00.8920@mx.google.com>
X-Google-Original-Message-ID: <ZQsB2U4QnumsxlIY@akanner-r14.>
Date:   Wed, 20 Sep 2023 17:29:45 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] checkpatch: stop complaining about tags suggested/tested
 by syzkaller
References: <20230829123446.3455193-1-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829123446.3455193-1-andrew.kanner@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:34:47PM +0200, Andrew Kanner wrote:
> If you submit a testing request to syzkaller it may reply with:
> 
>  syzbot has tested the proposed patch and the reproducer did not \
>  trigger any issue:
> 
>  Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
> 
> Checkpatch is ok with Reported-by tags, but complains about
> Reported-and-tested-by tags:
> 
>  WARNING: Possible unwrapped commit description (prefer a maximum 75 \
>  chars per line)
>  #48:
>  Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
> 
> Adding the new tag to signature_tags removes this warning.
> 
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a9841148cde2..f85dcfb098e0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -615,6 +615,7 @@ our $signature_tags = qr{(?xi:
>  	Tested-by:|
>  	Reviewed-by:|
>  	Reported-by:|
> +	Reported-and-tested-by:|
>  	Suggested-by:|
>  	To:|
>  	Cc:
> @@ -709,7 +710,7 @@ sub find_standard_signature {
>  	my ($sign_off) = @_;
>  	my @standard_signature_tags = (
>  		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
> -		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
> +		'Reviewed-by:', 'Reported-by:', 'Reported-and-tested-by:', 'Suggested-by:'
>  	);
>  	foreach my $signature (@standard_signature_tags) {
>  		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
> -- 
> 2.39.3
> 

Kindly reminder.
Please let me know if there're any objections.

-- 
Andrew Kanner
