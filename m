Return-Path: <linux-kernel+bounces-1423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FA814ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046231C24032
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678145C14;
	Fri, 15 Dec 2023 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A6cNi9MM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45649F67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso1968198e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702661292; x=1703266092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJgdaQfVEOqTf6cuulaJ0BP/0PqG9vdbBBj+6Nf4OLQ=;
        b=A6cNi9MM7UFbdYUBBSplxkAVXogSCfn+9QxF8Ft2BB9KIMfSdPnEOoG6c3B0r5Zm4j
         2blxH98ngsFTm8aWUzhNskxNN5dkMVCVoUs0qWIQyZ66wOWlkB8tZk2Ra3CUCF/9hUtj
         g0exxxpHYiNSyWGzP3505by1Z/0b5s84CoEhMGdxprQCmTf9Y5QiYfkAzPQUsx4h9EGs
         TbA8Pf8ITvqzPL0JTGcBsyEWOyXox/5dLjx1nxpRErCcvfc0lcJlhwwP5dnTpbAvzG/G
         I9B0xLLPEVE4NU2NiI4i5Gfqgq1aB0hpStJzSjffWQry/4kVCr6cyzRCPkcgRKs0Ow7R
         yjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661292; x=1703266092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJgdaQfVEOqTf6cuulaJ0BP/0PqG9vdbBBj+6Nf4OLQ=;
        b=blLGjkFoO8v2rOr+QTDE495Eh3W8XedfFGn0vdFDXvL6Q+ec+dJxhXkrTF2sEB3jlw
         oXDuNMVwx7TV8dlag1XQCme3usGu4g2F6mrk7EyJXjIKfsTqkj1U8zk61iR6EzRtxpjH
         BK21RJpBII7DlZDOQhb1igYNxZJ43q+uuqqmWagIoj9qisYVR3L0oflGk3gaeez3iOC3
         SJHVMLpjQ5Gm29LE9fyBdNwklTuLrA5goEUseqrNUhEnMC2djsQM/5IvMRkVzCS2n/PD
         Xthxp9flTPwNTdgvHPkPjc6aCbM4K8KVDA1tKHtBrPIqNhoqKSxBAao/K8hZy6xVzkR+
         x48g==
X-Gm-Message-State: AOJu0YyWH1vYB55PwfORwXh7aFXzr8jjztNImNswXEpGBOorcFz4RCJr
	8IOBKt0T1Vf6BeX6+HgBeOmK73tpUHdkrq9M/vpcVA==
X-Google-Smtp-Source: AGHT+IHKYDeE58bHo7Yl9+9lemxIyPXLPvC9cNQ8Niqe6fY5V8Hzg+SDAeHsy8YyZnBE7APvju7Ja/+sP0nqPq3dyiQ=
X-Received: by 2002:a05:6512:2354:b0:50a:a872:3b1c with SMTP id
 p20-20020a056512235400b0050aa8723b1cmr8848174lfu.27.1702661292417; Fri, 15
 Dec 2023 09:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com> <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 15 Dec 2023 09:27:36 -0800
Message-ID: <CALs-HsvjFhBnD=8HgcW3EStMioa7P1FvrJ_yGsXLHjUSEcm6ew@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:18=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All cpus must be
> considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

