Return-Path: <linux-kernel+bounces-146694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887448A6972
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DE91C20B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAC128820;
	Tue, 16 Apr 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsvlvjzp"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A6763F1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265977; cv=none; b=qPJCQY/PXFKRgB36QAHHe9lMSJ2b8MkcgiyVRFG4ZsQ1X/wQmcm2k12PGoDrjmnN3/+JVnCYQrjE0LnQO8h1bns1WHyrVEMHEysgfs83Al2dmuSl7L9Kag+hUQMfDSZSC4okKJN6hEFe1KV4DghKftZeFzEjh7axN2BDvjFhWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265977; c=relaxed/simple;
	bh=RsyS2R5oMv8R48QBxiYe2dLjRBF28dCziIVuTa+POxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGPKu1W3WtGFWL4mtZ/qLDk0IhpPalsii1kv+b1rPb++FI3CqrCRtQxPhvxLq3oTY/JcqBbHm1Sk4drwRQ8Im6BByjyE9NXHuZm0EKuSIIb/eFnwmODKbKNGYxEYes9R6FJZImMNg8ChRDyf3mTy17UMjP6s04ajNeknAakX99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsvlvjzp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343f1957ffcso2494001f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265974; x=1713870774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbUPOuMnOE/umSxfXm7CSrZKzlxGjr6mzObmpaJH4IE=;
        b=gsvlvjzp/3T7YkjjvJr/gJvtl7/2I2B0SryZJEGSw07sB22co7eIja6wHzwVlzzLU8
         /UMMcLt1rYBGkYP7++f58sFRWQjoZcdNUEFDiJNCSDZ1rS+2E78ip4t2f50O1zLqtAUP
         8oA6QHm2CNKNZxp/Q8akY82i7Psf5Xwl+F/a2G3HojaamAjBBIheCueu+Msh6v3Ie3/j
         RqpJDyxs+OZrSikDqGT+4+hl7hv/09lc3cMaORb8ZJTLwyO6tANqzDWkKKO1pPioi+HR
         hC5wTDJUMAmPxgi7ATCSlT8UuvQXygprmFjItWEKAU/s0TIBbB484d/k22/6BggwF/35
         EeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265974; x=1713870774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbUPOuMnOE/umSxfXm7CSrZKzlxGjr6mzObmpaJH4IE=;
        b=Hch+ABI9xiKc9Hj5NUKfm/p6ixl3mk+XUA9EqjYbL/Z15wLxQd81ttq/dfAGpLVgY4
         lHHD9HFy3BjuftttV7CZn3IWBJyeh0JrRlIRV2A/sN28JPELleqwc2p/Ksmd9N/BMKwJ
         1UV/fsmWqTywtzLEjKkz35d+jttuA8DfS8VhCjLhOEJ3XnNClmIB2pP/vgrf9El61AQz
         9QlE955/vpQOXF/pNfbpxid404no+2s2RMijblpfI/Yx1uOOnZ2zeOUSd8t0hdUwTG70
         qTYmXJzipkEKAQxWc0iYEUjbSRFFgs8oyP3YdNUZfNFcKDsBPGq+lMFk5p4VsZ9olKsp
         QZlA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ohu5LxsbxRzmRCe0GVU0XgWFhNOXQjZcNR9CGaLi3Yt1Mb+jG4aNYJKuHTUfTwfjZB5iGVjw1VQKLLNQ5l9y7ph9xV25wKnA1mv8
X-Gm-Message-State: AOJu0YwowSFK7BfV3lImluRBkjer2tHpoJ9GhI+Qs7czLY2VZPoaILic
	sLeAKrsJG17MoH4BfLfaBoOi/DacRiq/24lfPrVeS/BREKNs+Mb8mIAOOQQjlxvXBiM8tpsIqYw
	5DgjMbIWhL2ZP7gO082iA+13nhyQ=
X-Google-Smtp-Source: AGHT+IGlI9ysPcM/q8sX+RFxS+WBZPDDviQVyn1Ru5atuIOSfW45bZ3ZVP68betYRom20iMbJdzPzFEN26pdF/yIR5U=
X-Received: by 2002:a5d:5248:0:b0:346:20ea:2e5e with SMTP id
 k8-20020a5d5248000000b0034620ea2e5emr2033673wrc.21.1713265974040; Tue, 16 Apr
 2024 04:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416072108.5819-1-chao@kernel.org> <20240416072108.5819-2-chao@kernel.org>
In-Reply-To: <20240416072108.5819-2-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 16 Apr 2024 19:12:42 +0800
Message-ID: <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: remove unnecessary block size check
 in init_f2fs_fs()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:22=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> After commit d7e9a9037de2 ("f2fs: Support Block Size =3D=3D Page Size"),
> F2FS_BLKSIZE equals to PAGE_SIZE, remove unnecessary check condition.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6d1e4fc629e2..32aa6d6fa871 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4933,12 +4933,6 @@ static int __init init_f2fs_fs(void)
>  {
>         int err;
>
> -       if (PAGE_SIZE !=3D F2FS_BLKSIZE) {
> -               printk("F2FS not supported on PAGE_SIZE(%lu) !=3D BLOCK_S=
IZE(%lu)\n",
> -                               PAGE_SIZE, F2FS_BLKSIZE);
> -               return -EINVAL;
> -       }
> -
>         err =3D init_inodecache();
>         if (err)
>                 goto fail;
Dear Chao,

Can you help modify the following  comment msg together with this patch?
They are also related to commit d7e9a9037de2 ("f2fs: Support Block
Size =3D=3D Page Size").
If you think there is a more suitable description, please help modify
it directly.
thanks=EF=BC=81

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a357287..241e7b18 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -394,7 +394,8 @@ struct f2fs_nat_block {

 /*
  * F2FS uses 4 bytes to represent block address. As a result, supported si=
ze of
- * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
+ * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and it e=
quals
+ * to 16 * 1024 * 1024 / 2 segments.
  */
 #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)

@@ -424,8 +425,10 @@ struct f2fs_sit_block {
 /*
  * For segment summary
  *
- * One summary block contains exactly 512 summary entries, which represent=
s
- * exactly one segment by default. Not allow to change the basic units.
+ * One summary block with 4KB size contains exactly 512 summary entries, w=
hich
+ * represents exactly one segment with 2MB size.
+ * Similarly, in the case of 16k block size, it represents one
segment with 8MB size.
+ * Not allow to change the basic units.
  *
  * NOTE: For initializing fields, you must use set_summary
  *
@@ -556,6 +559,7 @@ struct f2fs_summary_block {

 /*
  * space utilization of regular dentry and inline dentry (w/o extra
reservation)
+ * when block size is 4KB.



> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

