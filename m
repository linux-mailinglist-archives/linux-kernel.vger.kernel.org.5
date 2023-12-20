Return-Path: <linux-kernel+bounces-6316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3681971B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA8C286C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30083BE6B;
	Wed, 20 Dec 2023 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G1qQ7DzF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546328BFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5a0dc313058so501721a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703042291; x=1703647091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=G1qQ7DzFK/ztH2sYXxjLo6olokvWbiUFdif+c3QnQc8WibAzRjm85/2S0sSl3sT3RK
         +aNIfv2ElHNkdkz2qawjtwwpXTf1xy+aTrl2XhVdulELGW3HHVqhNClMR3hvB/qJafg4
         MQ1kuoG9iqtA9gJpp0j4N8Obqa6TybDo8AIktrj7pjufShPm3EL2y/3EmCDjX65aYAXo
         /QYMEWyFHX6v0Lvv78ZKR16Vkq788y8rRo0znIby7soAIcEBmKKgkAEe++QepU2fd++7
         AaAmveI5cFyQoHqmempzrcXi6FdKZ4S7znhZREIx3XqaUOKm35RQoMzXf1rNdfBiJ/a/
         qlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042291; x=1703647091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=rVeQq1c5bzirBYNxvi4RZNRz1RK0+YGuYa3+w0HwYJxMyANF5SEW+qiNAMGdbkQH2I
         CWe1aHFHW6ate0vQHGCWw0aAee/0TBb10CE0EIgAch60tZUssl9MTTzIZyad0n3L/Xkq
         IvrNwR8U6842iUQwQbxLoOMTIpoOd29gpdffEF19yxGn8Y1rKPzBlDul6Y5LhdWigGib
         h9qX7j5TkNQz4oMLeyuhVrvhS6sXWJARdujsS/yafgPI5IbVqx5OYn32k24G2E2PyAqH
         Twl/yV6bsdFSmu9d2x4VMQJicgJvLCleH6htcmal1feenFvceKTZD4g7H+jiPx3nh55d
         NBAw==
X-Gm-Message-State: AOJu0YwWj4awERM2hpsoavtOvOJs6OeTYZ3ZJvzEkLgZ1TcxNHKiu5Na
	qGLNuDhdijWRc9QUwFI1ECN06g==
X-Google-Smtp-Source: AGHT+IGJy8KYnZyMHC+4fzSHET6hgmed+3GNH6+zA4QShlWQzZGtRyh4P66B+nvfNY4nmXMHOASd9w==
X-Received: by 2002:a05:6a20:3c8d:b0:18b:2020:8cd1 with SMTP id b13-20020a056a203c8d00b0018b20208cd1mr42952817pzj.3.1703042291622;
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78e46000000b006d088356541sm16958284pfr.104.2023.12.19.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, dm-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
Subject: Re: remove support for the host aware zoned model
Message-Id: <170304229020.683808.16849978519505449769.b4-ty@kernel.dk>
Date: Tue, 19 Dec 2023 20:18:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Sun, 17 Dec 2023 17:53:54 +0100, Christoph Hellwig wrote:
> hen zones were first added the SCSI and ATA specs, two different
> models were supported (in addition to the drive managed one that
> is invisible to the host):
> 
>  - host managed where non-conventional zones there is strict requirement
>    to write at the write pointer, or else an error is returned
>  - host aware where a write point is maintained if writes always happen
>    at it, otherwise it is left in an under-defined state and the
>    sequential write preferred zones behave like conventional zones
>    (probably very badly performing ones, though)
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: cleanup zoned device probing
      commit: 77360cadaae562f437b3e98dc3af748d8d75bdc2
[2/5] virtio_blk: remove the broken zone revalidation support
      commit: a971ed8002110f211899279cd7295756d263b771
[3/5] block: remove support for the host aware zone model
      commit: 7437bb73f087e5f216f9c6603f5149d354e315af
[4/5] block: simplify disk_set_zoned
      commit: d73e93b4dfab10c80688b061c30048df05585c7e
[5/5] sd: only call disk_clear_zoned when needed
      commit: 5cc99b89785c55430a5674b32ad0d9e57a8ec251

Best regards,
-- 
Jens Axboe




