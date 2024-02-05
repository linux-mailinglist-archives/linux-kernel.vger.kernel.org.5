Return-Path: <linux-kernel+bounces-52836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5A849D42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841DA2822BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E642C1BA;
	Mon,  5 Feb 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZnA9K7q"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E242C19E;
	Mon,  5 Feb 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144248; cv=none; b=lVYf/mqOX1vDa8Ac6vnu/j/gl+XoWBCwfLDJFIhqZ98cQmXn6jRalRH/tfw23iXleCazJ6ha9hShUgAN72fFHPlnj242WEinZnM1V++ra2zoYh9zk/rCIvZpOD972LyLX3RhulzMLunqoqU8jyw5g8A3z7iDZe8/TiaevAjVxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144248; c=relaxed/simple;
	bh=cQnh+MeiQmdzvtMCYAa40uDRrJY4G2mp+bIqGXf8FJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRwcWn7vs41GeEGXWYc0PxIrobm+Ux0Qlqa/NaaA4AW0TqsM3uYEzGacbVDWjhg9wjfBniWFwrA/sVjzrzHKmSCoJDEG47t48iHrUBax1HiN3Y5kxvwcFlCYsQMjLIYdwaPIUFJJsGDP27SPXHkr3jjkWOJJR7WxdWrQUsDxZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZnA9K7q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0a4e8444dso15089611fa.2;
        Mon, 05 Feb 2024 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144245; x=1707749045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF+ioF4rU6hYdKskdmBXlkag6Ll/8Irxamnq5jEhMXI=;
        b=TZnA9K7qWi59dzk0FLjuvn+ZlhQ+qkaaMkYFx2/3h9QIuzzFQ6V+9LtwWCOPh7auiN
         Uj1afEy7jDdZIGSashEyig6wbq0pq7jdqrrpCIPkt29W7jUTpAaUVOqN86X9223U4FRD
         sKW9WEg09xkfUUXA7aGRH1SPUiajZLL1Ss/JA7ctbFGe/0cGNZVRXDFrGrU9YyHO/Fts
         1p5OOtMvvlXuyu/Lq+2cnxb2aDYb6Ee5m/Xd/Xw0NY3en05OI8EN2+TbAqs7PzPPRMfQ
         bwd/9sE7zsjlDr3yqXpmVMVjzTMXT1521Ur6OjAdVA0yRp7kDCudzxPo6ZjoZxzrXU16
         m54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144245; x=1707749045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF+ioF4rU6hYdKskdmBXlkag6Ll/8Irxamnq5jEhMXI=;
        b=MGdJfSKCDzbGHl7lV9qTmV4AZEsVIpO5WTiZ3gz4W8IADrVWYj1T4/Mpcl3c3krB2E
         ztE62jqnNlxp7sJ+KfkME6W7/mkd4hfDf36vBwR9xSYtBaloMfhmQG3QTngXhOv++5OB
         bRKEgQF8yb9QtIN5fX9tsfUMX8oA0f+0StJd2xlY8DaU8v+15/Wy5MZq+5RugUTK7Xil
         TBAf3AirruGUnxF/u1icYzcvkhDWToFpx52vqLaq4RS6lYvuubIZCH/nVMXpAS8Q4aiT
         Wnk93yUfvmeaG2I26Yj1Sy4B9GfT1O64rUsRC5O1nP/wlzfptcDteLJShRHa7w/n3frO
         0j1A==
X-Gm-Message-State: AOJu0Yw4WbeTpOJUqWl0ChjsaFxBM1//Nq5BCXn5HViJDFDeoFk6FknL
	YJbJd973LpWH6FIVaWSZAqsQVjjyNt4osGpmLK5r4QHcquvbUUkaGzJQvqopKpIjvk2T7cxuOio
	DbJPKzBW3pm1uR3NhxUNr570/qQ==
X-Google-Smtp-Source: AGHT+IGmWKx8ItqhTYnDkpaf28i4Fx1v2apIgAI/fIL955Sgbj0u6jNf4TZdLG7QNW8CbT27NNtf1zL8vJxNXjynXgY=
X-Received: by 2002:a05:651c:214:b0:2d0:aae6:bf2e with SMTP id
 y20-20020a05651c021400b002d0aae6bf2emr2255789ljn.34.1707144244549; Mon, 05
 Feb 2024 06:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205104905.24929-1-alice.chao@mediatek.com>
In-Reply-To: <20240205104905.24929-1-alice.chao@mediatek.com>
From: Stanley Jhu <chu.stanley@gmail.com>
Date: Mon, 5 Feb 2024 22:43:53 +0800
Message-ID: <CAGaU9a8EQDdrrgzuaqBYk6h-r4u6spozH3cHeHO-98dNjEv-AA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ufs: core: fix shift issue in ufshcd_clear_cmd
To: alice.chao@mediatek.com
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, wsd_upstream@mediatek.com, 
	stanley.chu@mediatek.com, peter.wang@mediatek.com, powen.kao@mediatek.com, 
	naomi.chu@mediatek.com, cc.chou@mediatek.com, tun-yu.yu@mediatek.com, 
	chun-hung.wu@mediatek.com, casper.li@mediatek.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:27=E2=80=AFPM <alice.chao@mediatek.com> wrote:
>
> From: Alice Chao <alice.chao@mediatek.com>
>
> When task_tag > 32 (in mcq mode), 1U << task_tag will out of bound
> for u32 mask. Fix this bug to prevent SHIFT_ISSUE (Bitwise shifts
> that are out of bounds for their data type).
>
> [name:debug_monitors&]Unexpected kernel BRK exception at EL1
> [name:traps&]Internal error: BRK handler: 00000000f2005514 [#1] PREEMPT S=
MP
> [name:mediatek_cpufreq_hw&]cpufreq stop DVFS log done
> [name:mrdump&]Kernel Offset: 0x1ba5800000 from 0xffffffc008000000
> [name:mrdump&]PHYS_OFFSET: 0x80000000
> [name:mrdump&]pstate: 22400005 (nzCv daif +PAN -UAO)
> [name:mrdump&]pc : [0xffffffdbaf52bb2c] ufshcd_clear_cmd+0x280/0x288
> [name:mrdump&]lr : [0xffffffdbaf52a774] ufshcd_wait_for_dev_cmd+0x3e4/0x8=
2c
> [name:mrdump&]sp : ffffffc0081471b0
> <snip>
> Workqueue: ufs_eh_wq_0 ufshcd_err_handler
> Call trace:
>  dump_backtrace+0xf8/0x144
>  show_stack+0x18/0x24
>  dump_stack_lvl+0x78/0x9c
>  dump_stack+0x18/0x44
>  mrdump_common_die+0x254/0x480 [mrdump]
>  ipanic_die+0x20/0x30 [mrdump]
>  notify_die+0x15c/0x204
>  die+0x10c/0x5f8
>  arm64_notify_die+0x74/0x13c
>  do_debug_exception+0x164/0x26c
>  el1_dbg+0x64/0x80
>  el1h_64_sync_handler+0x3c/0x90
>  el1h_64_sync+0x68/0x6c
>  ufshcd_clear_cmd+0x280/0x288
>  ufshcd_wait_for_dev_cmd+0x3e4/0x82c
>  ufshcd_exec_dev_cmd+0x5bc/0x9ac
>  ufshcd_verify_dev_init+0x84/0x1c8
>  ufshcd_probe_hba+0x724/0x1ce0
>  ufshcd_host_reset_and_restore+0x260/0x574
>  ufshcd_reset_and_restore+0x138/0xbd0
>  ufshcd_err_handler+0x1218/0x2f28
>  process_one_work+0x5fc/0x1140
>  worker_thread+0x7d8/0xe20
>  kthread+0x25c/0x468
>  ret_from_fork+0x10/0x20
>
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>

Reviewed-by: Stanley Jhu <chu.stanley@gmail.com>

