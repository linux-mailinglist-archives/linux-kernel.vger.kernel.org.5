Return-Path: <linux-kernel+bounces-12386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D833881F407
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EE5B2176A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E771104;
	Thu, 28 Dec 2023 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNaEPMIB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527A10E4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-594e14ac876so423659eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703728843; x=1704333643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XYXLeAK9wBLJ9SgEUKly8RlAfrBLaG5dorpT3mCDAA=;
        b=JNaEPMIBUIfUi+HLlX+E0DD3m/tl1uP20a7SL1BtywGlxfGvAVK50wp2vQib7cKEdO
         PwB/K26ZJbd5hdX1wH0FhPJt775E+BOrBciNhlfUtaB/VDnlx7EBfn0olqO663XNAYBo
         Sv6hPaAlvzzzK2RLgDUVep+Ie7UbsTaLnWLK39wg9CUnrjc70yCSliH0VWIvd0Qmjn/g
         iYy6fI1JDJb4ItPEsObPDD+83iiqNSD+ZO+0kFP8+H9ONQdMyJ4VS1/wprZuIgew4JCd
         2AeCQVI7ZEZmVKsh/ojgwSbz6gO/gI8p/0idgeUEWPDwAPexPJH7+zxzXHktmJNWlImR
         sWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703728843; x=1704333643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XYXLeAK9wBLJ9SgEUKly8RlAfrBLaG5dorpT3mCDAA=;
        b=jyndNbLO0UgSJJzKLyQr4Pnp21SAqJJ8fA9S6z31YyjUcSNxW38Po5hNOwUUW3wkhv
         PL9eAQtdFmWC59rfSqrJZoZty7DrjgEnSBLr0WSrixG62+vs1HfnMN+KVqwo4XBVoMi6
         NvqBFkjOELCT5kbl6SMwcyitUc767r706M48O3Qyx9JEHd4ygkfrokBTorVvZJ6xfumv
         /Qq/79/lNSpnId2JIDvXX9T4hmRC5mJ0UswbdWj9g2Cp13o/Eu+HxP97JjHeZp5zMMvv
         bqxTDEyJaRZJ/TrCu7o5JaKLgj2NFhF3yYSnVJTiYQQqxKSAzBm0L6wytaVapGX77U5W
         uAKg==
X-Gm-Message-State: AOJu0YzOu8oazEjRpjamUnEj2v5M07Em3qCRks0a8KDNBQbgwVRqTXUc
	w/vrGbJRcC2PurLxeJAs64a/SKJZyho=
X-Google-Smtp-Source: AGHT+IGRshJlPiXSge4dnsgvoWquCvFxA6GM3UT2zroScMehPVdGEFbXAhjoMTYI/u47Cx59zwoCsQ==
X-Received: by 2002:a05:6358:2921:b0:170:bfb9:1cfc with SMTP id y33-20020a056358292100b00170bfb91cfcmr6974231rwb.1.1703728842738;
        Wed, 27 Dec 2023 18:00:42 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id p23-20020a635b17000000b005c66b54476bsm11505761pgb.63.2023.12.27.18.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 18:00:42 -0800 (PST)
Date: Thu, 28 Dec 2023 10:00:38 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
 bugreport@ubisectech.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] erofs: fix inconsistent per-file compression format
Message-ID: <20231228100038.00004fdf.zbestahu@gmail.com>
In-Reply-To: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
References: <20231227041718.1428868-1-hsiangkao@linux.alibaba.com>
	<20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 13:06:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS can select compression algorithms on a per-file basis, and each
> per-file compression algorithm needs to be marked in the on-disk
> superblock for initialization.
> 
> However, syzkaller can generate inconsistent crafted images that use
> an unsupported algorithm for specific inodes; thus, an unexpected
> "BUG: kernel NULL pointer dereference" can be raised.
> 
> Fix this by checking against `sbi->available_compr_algs` for each
> compressed inode.  Incorrect !erofs_sb_has_compr_cfgs preset bitmap
> is now fixed together since it was harmless previously.
> 
> Reported-by: <bugreport@ubisectech.com>
> Fixes: 14373711dd54 ("erofs: add on-disk compression configurations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

