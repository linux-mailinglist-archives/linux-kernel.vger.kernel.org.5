Return-Path: <linux-kernel+bounces-91096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCD870985
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F491F2702A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67E626C6;
	Mon,  4 Mar 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx7XLgic"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0661675;
	Mon,  4 Mar 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576863; cv=none; b=uu++5/vfq/gL1v3WdBWXqoizOvvFqc5l9Zfaclst9yPaq93VM1needhjs3i6FDu2ibbrmRoed4RVZzDCDK2cLxk2GgntOnBTOFSKxzA4DAUqAHoCvYKC/cKa7bnkDPXx2Oq+MZQjJQGAn4nBuNwkzhyP0jykYu85fKVAjPXzxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576863; c=relaxed/simple;
	bh=fA5p4w2UAKT55clHGlZaFH4D9YSLg1VtWskiVCls5Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLjZ8EPowWiER43slk5TJk0p9xe74ILggQyF0+CJyhikkEo4OA94ZGzzYnTEG+NXvGg+L7ai9F8Uue0YE+e1QiNXJoFTjW99urKYs8TXHrm3rifh8VjM0c3raB9bDAi3V/RkKUv+b4wDj8QFFLqmaQgV/3rOTDmGK7N3aAeO2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx7XLgic; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcdb9d0cdefso885082276.0;
        Mon, 04 Mar 2024 10:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709576860; x=1710181660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fY6/K6G2r7+NzeCbDJRHUKraEj8DaHdwVJ1zy3xyb0=;
        b=Jx7XLgicXcgNNBQ3QXw412Wb6uU2zjk7rRRc0QsfeoV+eGQI4gBQvKoFopMVq16T/Q
         NP6swAFfuZBdYUDp4opnF5/QhrWzXekEqP4NBkzlQtPVwCu1xaeMEqyearUBNJDNjY59
         IPCCxWR4hsUZ8RwITHjrkseKksdwUyoSIIUB+e6zci2hYxfj3V71MzmJXyEMe6/CI3od
         fKPgleDHaxdYuc9YeD0T+RRax8MHsHAXhBjnhD7KEmfmdmNzxRlGvPsJ0OVEhsD0RgT/
         FwyWInSkMs4d3XPIXfLeKRL6szG7YgC4+MM/SYWnL0axzpa63XXrOtXlD8JrWLrGvDAY
         nZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709576860; x=1710181660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fY6/K6G2r7+NzeCbDJRHUKraEj8DaHdwVJ1zy3xyb0=;
        b=UtE+5uR0APzfNgZbdxoEFbTrE0ZinNirXsgdNPJ9ePXWGNTeLRsol4z8qAjpS/gCoe
         BskYY9rQS6sMtNStWGi4QXjPxRGpEuEyk2eZgc9uABvFnF9PxSHCYk6nq0WekAvn4s8v
         dIezXDi9DatFhATdKtYs/vjSLR58uGYJLRKRpFvjQxMYULZMRS9AgTvh3T+el1Ro9D87
         YrJ+2aFl6YlI8pcK0wsuNp1ZSAhffZqPSB0zjYq4tc2rHJOFJo5wb3OnKqzpGrkqr2RC
         4CN7+Kzj4c52RJ5OMxgFj2rwG5P/DKk+2ghH4FbHWMQBpjlaN86fnxOeAgi8XtShLMd/
         oUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzVMUYGI047U6huG5b5laHX2bfiT+I+fMbe9/hybI6e5Sj9r/BQb+bLv4W1dolhZoe7rphreU++r1biShcPsMre3Sqs7q+LVdxuFj62OGwXMfTz5DQV5av3qhEJYPvgcsbRaQyoT/NgJPhHzgaF8X1oW5DW8YHxydj1vzowhK2uZVSEodWdNTWQ==
X-Gm-Message-State: AOJu0YyxVttN6FYIMe4YkHwahXN1xL35rJdLRBHPXF1w+xP0R9CtcMcd
	R1pAHUTHH8rik74OkdH+/8O57QQWV8U+1FOxkXUlrhiTdRilabT+I/LTHQB82ixA4IGrDy1mePs
	fkcHeWlNSpyHkqOyOxqIwh+WfuUUvsPUdehU=
X-Google-Smtp-Source: AGHT+IGnVOofktzGqRKelWII7rR2f7/3nD/nhtqjsuJ9LvkIen82+AjAUzOSo9JHnCEmRPYwF3U9Q/XfBZJmrJQGORs=
X-Received: by 2002:a25:84cc:0:b0:dc2:5237:81c2 with SMTP id
 x12-20020a2584cc000000b00dc2523781c2mr5402639ybm.1.1709576860215; Mon, 04 Mar
 2024 10:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304090649.833953-1-usama.anjum@collabora.com>
In-Reply-To: <20240304090649.833953-1-usama.anjum@collabora.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 4 Mar 2024 10:27:28 -0800
Message-ID: <CABPRKS9KtaD6O61__3Vv73cvd1bxJT+zkeroGnStbPz8pYhmgA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: lpfc: correct size for wqe for memset
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Justin Tee <justin.tee@broadcom.com>, James Smart <james.smart@broadcom.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.com>, kernel@collabora.com, 
	kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The wqe is of type lpfc_wqe128. It should be memset with the same type.
>
> Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use *wqe instead of type to find sizeof
> ---
>  drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 8258b771bd009..561ced5503c63 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
>                 wqe = &nvmewqe->wqe;
>
>                 /* Initialize WQE */
> -               memset(wqe, 0, sizeof(union lpfc_wqe));
> +               memset(wqe, 0, sizeof(*wqe));
>
>                 ctx_buf->iocbq->cmd_dmabuf = NULL;
>                 spin_lock(&phba->sli4_hba.sgl_list_lock);
> --
> 2.39.2

Reviewed-by: Justin Tee <justintee8345@gmail.com>

