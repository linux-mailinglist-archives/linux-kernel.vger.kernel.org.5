Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE587CB4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJPUdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:33:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E2A95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:33:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f8a093so48925625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1697488426; x=1698093226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ9BtdqwDXWvlUu5+crwKKtDfxbIrKYCTnQnNPyEDHw=;
        b=T+/0wPOOT3JO3vbHK/gJ3ETTToJoApVmY6B3Rhxsflu+cC248ue4QtU1ds0w/6gJwM
         CRUzZCG465f5FOZm+oXBbyiEt008x+TJh95CRFBRObN8rCZKQ3ke3/L9XRFvUAVZHzRz
         glzq6liZcXwTkbISV/01gHFTf9smgDWpXhlZESXTbLrTbtXlQvpBs2jQJ7NSI8cPNqtW
         teaZk2XhgeV9vLek73Oi7J9P82QI/DwzTA5nXIKeB54oBtGHZyV8koRwdqBH7JvA9ibM
         K671m5HIzlWXf6mzOFXWPb5mpkFKuX3wacBT7hC2hthHujY6sQlY3DAK2uMXP5MHZr5u
         61QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488426; x=1698093226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ9BtdqwDXWvlUu5+crwKKtDfxbIrKYCTnQnNPyEDHw=;
        b=SmT9OH0PANBMJUl2b5KmEreIbX9gNgjMheD0TeW3iJdN9tlknwjqG+wpbk02E3VFNa
         SdGgYiLFMh72TUCNiEL9p6ZX0rhgiLdhR4SH2pQi7EQOLORndB1u4VBW3yjSrP8ZlhtM
         aMt3rIIuF861ztcPdbNikLA+UJSewtxB36VtPq6yc16qnlAHJOrLHDc5siX57FhyAAVJ
         N5QbAM2A+pEgXpoflRQq9NRwGiX85zYWPHLMb4XeLQkojkDC6vZ+YJPPWFbOsfumRbZb
         yMmKjvQO/FXR7dTvUugSOdzkUo5uAMeuI1Uq3jH4LQHTBGLm+DsJi42AvtQ5DAvhH2IT
         9NOw==
X-Gm-Message-State: AOJu0Yx9HEAQFmwGYB1skL95HkpcY2GNMDh82OoXjF0S3Llq0C1fEj1M
        7BVu9Mc7KT+Ai6uL3AAaOGcGfftj1QQH5H2Jcj+oEg==
X-Google-Smtp-Source: AGHT+IGbaW3mGv5Zf5QVTVC29JgOd7v6yK58D/Ss+jZE1IKx+hSS/37YXJ7M6drTDmpkRsk3mQjzJg==
X-Received: by 2002:a05:600c:4686:b0:401:be5a:989 with SMTP id p6-20020a05600c468600b00401be5a0989mr185786wmo.23.1697488426193;
        Mon, 16 Oct 2023 13:33:46 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b004065d67c3c9sm67060wms.8.2023.10.16.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:33:45 -0700 (PDT)
Date:   Mon, 16 Oct 2023 21:33:44 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: Missing a blank line after declarations
Message-ID: <ZS2eKOZF2J7q7zkE@equinox>
References: <20231015172846.7275-1-edson.drosdeck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015172846.7275-1-edson.drosdeck@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 02:28:46PM -0300, Edson Juliano Drosdeck wrote:
> Warning found by checkpatch.pl script. Adding blank line after declarations.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> ---
>  drivers/cdrom/cdrom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index cc2839805983..ae30390731bf 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -985,6 +985,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
>  	struct cdrom_tochdr header;
>  	struct cdrom_tocentry entry;
>  	int ret, i;
> +
>  	tracks->data = 0;
>  	tracks->audio = 0;
>  	tracks->cdi = 0;
> @@ -1038,6 +1039,7 @@ int open_for_data(struct cdrom_device_info *cdi)
>  	int ret;
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  	tracktype tracks;
> +
>  	cd_dbg(CD_OPEN, "entering open_for_data\n");
>  	/* Check if the driver can report drive status.  If it can, we
>  	   can do clever things.  If it can't, well, we at least tried! */
> @@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  {
>          int ret;
>  	tracktype tracks;
> +
>  	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
>  	if (!(cdi->options & CDO_CHECK_TYPE))
>  		return 0;
> @@ -3038,6 +3041,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
>  	int ret;
>  	struct cdrom_subchnl q;
>  	u_char requested, back;
> +
>  	if (copy_from_user(&q, (struct cdrom_subchnl __user *)arg, sizeof(q)))
>  		return -EFAULT;
>  	requested = q.cdsc_format;
> @@ -3063,6 +3067,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  	struct cdrom_msf msf;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
>  	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
>  		return -EFAULT;
> @@ -3083,6 +3088,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  	struct cdrom_blk blk;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
>  	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
>  		return -EFAULT;
> @@ -3177,6 +3183,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
>  					       int cmd)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
>  	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
>  	cgc->cmd[1] = 1;
> @@ -3190,6 +3197,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
>  						 int cmd)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
>  	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
>  	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
> @@ -3230,6 +3238,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
>  {
>  	int ret;
>  	dvd_authinfo ai;
> +
>  	if (!CDROM_CAN(CDC_DVD))
>  		return -ENOSYS;
>  	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
> @@ -3248,6 +3257,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
>  {
>  	int ret;
>  	long next = 0;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
>  	ret = cdrom_get_next_writable(cdi, &next);
>  	if (ret)
> @@ -3262,6 +3272,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
>  {
>  	int ret;
>  	long last = 0;
> +
>  	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
>  	ret = cdrom_get_last_written(cdi, &last);
>  	if (ret)
> -- 
> 2.39.2
> 

Hi Edson,

Thanks for the patch, looks good to me, will send on for inclusion. That
said, I will also tweak the title/commit description to a more imperative
style, given that this description itself currently triggers
checkpatch.pl due to line length.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
