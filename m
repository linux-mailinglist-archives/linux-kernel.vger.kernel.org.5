Return-Path: <linux-kernel+bounces-46165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319D843B75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962611C22CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A469963;
	Wed, 31 Jan 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ULRR9VR6"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369669943
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694744; cv=none; b=LdYT8Yv0J0vyFy/D09qzdgla4SbH0I03dj2+AbVbehmGAhw3rBkHf1ZiXJskd9C+pwkdgldhVKWoQhQqxnfBNWED5gg4csM/g3NuBeUE/7PK1fx5WgJ4mFv2Bo9aOtawo2isSC6PovygG6LHRCflUz6m3a0n3vNJxf5ACaF+ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694744; c=relaxed/simple;
	bh=P3+v3yLulzw5vIe79QB+h9fFvdCNzs3D7gL5yvhV51Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1rgPICkqTMwBBBPzp4tG7FmjScu89RV7HRhAylbq6Akgz0HGe2wEN7mrpY95kq8JnqA/8Djd23U/m+QgavO+fhsIXYGec0GlpkoFL9yUHKLALZ0aYFxgeCppuV/9Dtm9ou0a/NqfHwg+uUoSO3yy4KDNXhfXLzQal943JmNY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ULRR9VR6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so58288971fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706694741; x=1707299541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3I5V/fXXERD+GB0c4yW+RcWcr030eusZejPJmG3ANc=;
        b=ULRR9VR6hedCMN/npq7GYh1xmEUqWIEwCwID9aOpBm9e7mzXJiB11JXjxQwVwd9zLF
         IbYhF4AEopeZuTgd0AxEo6mCORmbX6Qu1Dk0QTqXpzdLoG/3MvP7zt3LP5izPFQuh7uM
         o7fkNoO6Cka3ap6Eyj/xqlNxftpDQTAnDn6EJNdmHHE5HdJlb91ndxRP+7DS8XNY0xs4
         IMeaF23oF0BSyVps2VGoo+RNtjfFg8gG+lyr9mGGFZk3u3HOY5m+N2/OgPxLlN7yVTCB
         f0Y4vRx4d4KX/bxCaFVPlAsLY4bjGZMWs6fuCZ3wKe7gEjPz8a95cF7MW0ATmeTJ2on0
         BjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694741; x=1707299541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3I5V/fXXERD+GB0c4yW+RcWcr030eusZejPJmG3ANc=;
        b=FHTd+vGXN4By/f1yX31WLdyQs+ZKCl/PScfmKECgKU6pUihqoNTP4H5CivtUP8TE3s
         wsA4u0KL2Gl/3/7QAgzH83LL6huQU/GuTfCoqHAbEOGtSK1pdT/0r/Bu6b6U8wI6Sxuz
         eQC3Kp4VdFStvGhcWHJ+ZP1xSuWgCPR+LOi8j9ij+nuptfMTogoxM0yG6j3yJeolq2ne
         Q7GLsisz45OPgk1ICixGVStM7b/ik9854e4ud4NZwKNnbAMwrD6Q51tmcbSxC5EsejLx
         AU5J3pV0lQ50MOwtVu5adcFoejunqNZt/uifl6w9xgfV2QACeP8mJHbUYZvdp16043iY
         yQuA==
X-Gm-Message-State: AOJu0Yx7Yx7Stf0jBr72WPTPn8BxN7CMXT0PQEvoJFSPs0blBa16QWD4
	cYxVzusdRzh6GlFdYKHunoLt/l2CFJ7KLBGtZpgNai5jmlFdkvhcVkzeHU+WulQ=
X-Google-Smtp-Source: AGHT+IFHloWOpJa3+8LiptW53WtkE1KD0mNdsRTIb/f+DXodIALBrnnEytEXxDcNAkG1n8S+2QEPRw==
X-Received: by 2002:a05:6512:605:b0:511:20a4:c326 with SMTP id b5-20020a056512060500b0051120a4c326mr822484lfe.35.1706694740872;
        Wed, 31 Jan 2024 01:52:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/QBLtJr9hqWAYbBzOIjiyAwafwZGHp22JP3M+r0g4QHJ/kcN1GbYhuGt4IimkiRy7jENN8cBJ+7psNNAuw6dqUBFmmslaUj/L7cjtoI6qDen7QRfL82YmvY1q0PLcwPtebAy1Fv/rXAtXLT4ab/xiNusJgY347Cv8YjZj0Yiypwnt57G4AYRltIEXc5HpF39Zmq0WaLeNVDdEY4QUyvis3St0pLJplcKSN07ezlgbBv4cnFE9MjKPWimWtgORU14ipjUCnID/lhB3u9q5zoT+I6qEc+uXzBspqmEMPpU7v2m8/zRlJRglzXDq
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b0040e5951f199sm1057552wmc.34.2024.01.31.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:52:20 -0800 (PST)
Date: Wed, 31 Jan 2024 10:52:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [PATCH v2 0/2] Dynamically allocate BPIDs for LBK
Message-ID: <ZboYUXiT2H40mWrL@nanopsycho>
References: <20240131075441.17227-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131075441.17227-1-gakula@marvell.com>

Wed, Jan 31, 2024 at 08:54:39AM CET, gakula@marvell.com wrote:
>In current driver 64 BPIDs are reserved for LBK interfaces.
>These bpids are 1-to-1 mapped to LBK interface channel numbers.
>In some usecases one LBK interface required more than one bpids
>and in some case they may not require at all. These usescas
>can't be address with the current implementation as it always
>reserves only one bpid per LBK channel. 
>
>This patch addresses this issue by creating free bpid pool from
>these 64 bpids instead of 1-to-1 mapping to the lbk channel.
>Now based on usecase LBK interface can request a bpid using (bp_enable()).
>
>
>v1 -> v2:
>   - Modified commit message.
>   - Dropped patch2, as for now rvu netdev have no usecase. Will
>     be upstream along with the CPT driver.
>   - Addressed review comments by Simon Horman. 
>
>Geetha sowjanya (2):
>  octeontx2-af: Create BPIDs free pool
>  octeontx2-af: Cleanup loopback device checks
>
> .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  14 +-
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  21 +-
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 179 ++++++++++++++----
> .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   8 +-
> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   3 +
> .../ethernet/marvell/octeontx2/af/rvu_sdp.c   |   6 +-
> 7 files changed, 181 insertions(+), 52 deletions(-)

FWIW: I don't see anything problematic in this patchset. From that
perspective:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>


