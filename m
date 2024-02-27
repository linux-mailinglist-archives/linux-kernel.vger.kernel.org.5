Return-Path: <linux-kernel+bounces-83248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A98690C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408172846C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E613A251;
	Tue, 27 Feb 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FRNitX/3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B44E1C9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037778; cv=none; b=Tkibx2OBwSDToT46iLSxL7t+vNlrh4Kc7hAQRSVIya5Sfr/+Z7Lia/Pmc+gwJM1v6aK8oUouaqf+1hDNBoOTYG7bERth4jfAVUt7MIGACkEI0IdQg/7Kd3LfzY/hHdEHYyyh2Box3TLOJlE8kJniznlJw7Bw+pIhWQlfce3q1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037778; c=relaxed/simple;
	bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyP7u17rACaJ9D0dVs2zd3MPWLUC7kYr3xkCH1e77bQqIrL+sPhbyh9mJCWSa5rQJINHvJ4xvhqGZhSen4Etysw8Xgc7AlTxcAHm00lWNHgxhDOIFsd0vWZ9bL3+trF0lGUEH3WJPovscH27ktJ2MglacLJZ6355aXFP/Ket1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FRNitX/3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so518814566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037776; x=1709642576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
        b=FRNitX/3phqEKfvp1vBhfjwl2WJj0SkWFGMEfe6BmjguvPATVVmUt1NMUlslRZUrZ4
         ptJzP2fak/EqjTHs9hYnYTHp71rn78wP9df4wgbXmNIE/bIRgj172rTucoNKDcgDQEDJ
         XMb6vf28sz8jJEs6N3BgfqBezDDhYhoHwcMC+o8JUkigU9qPjPD/NM3j758cmsAXsUsk
         EIm2PUHAFZdJbzCgR1DSJsVVZ9sijzFJ3ddJf57ZsZ2QEKcwxBRVL0lzMZwv+Bn4W6D4
         rJrNilT/P7fythJGQKRu/h3FYLDvuJTviPFC9fMdSTcV3k1VfpPI2if4SNu6gdbnAjNm
         WvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037776; x=1709642576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
        b=WFHWU1HWFPNq5lLoRtbrGUT8BkONcMGycAfa6bcE5OBGbeOnIoiQLxmn6Pf0ToGhrO
         MfGm6TPooVt8Wt792uxb8kGJFfy3j451u4iPEeJnKPkuXgUDsXtxOJLw+LQ/yFBfhHyW
         d07LxDqWxRa+Redt1ozbp+SMj5JWZyylQbxRYF/eKl7IDFBUBOPdE6JwQg4ClMw+IOiI
         BOI9fqs5MPQ3igWyBi/TBv6KUfV5V3WIcWGXM+DjmiMFEWcw8fq7+ILkXs2KOv8QzoRM
         DM6xapERc3soj+5LHW7+iXOfbP8y0fHmKozAhmfEBmss5c+ogVC/ofMIBL1GEFfXc9wO
         NxzA==
X-Forwarded-Encrypted: i=1; AJvYcCW8EaoSBW+BJzq6xeYqyDXqiHZD91dO+RgJWcNn0xqTZcDCU8iOIWsh2HJF8y+nQjviU6lY5cAs3dbflM1g0awt/pFCCcq+LoOau/2G
X-Gm-Message-State: AOJu0YzA55Z6rpXWtimrC9p+NIkPxfG8xMxCpIKPgmogUNvGKa3HnaRu
	1ZSL3ugKTtzUStQzrUjZiPu+MJ4Jnhbl96V2VG0ah8QI6tXXdgukXjRcLwoEEFoBTQ6Blo8gvyH
	VmZU=
X-Google-Smtp-Source: AGHT+IFFe+nUVUhX+MMWNH2IJun8mSZ0et2RQYBeYfLf/75PPrwHyIDDQoIOAHjyxvm3DUikHd3MiQ==
X-Received: by 2002:a17:906:f144:b0:a43:3f37:4d94 with SMTP id gw4-20020a170906f14400b00a433f374d94mr4254318ejb.16.1709037775705;
        Tue, 27 Feb 2024 04:42:55 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a19-20020a170906469300b00a431fca6a2esm741474ejr.37.2024.02.27.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:42:55 -0800 (PST)
Date: Tue, 27 Feb 2024 13:42:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <Zd3YzNCsTIBzjAjB@nanopsycho>
References: <20240227084722.27110-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227084722.27110-1-hkelam@marvell.com>

Tue, Feb 27, 2024 at 09:47:22AM CET, hkelam@marvell.com wrote:
>Add support to read/decode EEPROM module information using ethtool.
>Usage: ethtool -m <interface>
>
>Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
>Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

