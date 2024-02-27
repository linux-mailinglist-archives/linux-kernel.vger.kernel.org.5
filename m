Return-Path: <linux-kernel+bounces-83521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE4869ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4819B2866E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A114690A;
	Tue, 27 Feb 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kc0AXjOM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD7146002
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048565; cv=none; b=TobXoALHBHvbF3L8lJ7INaq7nTstFnWAKee2qWhQInkbQ8Gnr5p1Drt15TXBtZ5qtz3PulG08meltrmyfYMITZhLScgv6Y7nP6j5ykzS3Hkk5GXbo406mv7X+SIHQuIbb2VCs5Yi0AKUYOEdRSei26aHyiuSSwO3mjUjK1FYt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048565; c=relaxed/simple;
	bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMKOSryZdoTcTlq0elvn1E2NDoGHQihuXbTeYG72fDMYEY4u7ffHk+qmeDOhNdoamk66BGxV+0Ua0zYZGsb25vr/C1dwnUmz6yAUQEyz7KTTF3K8iMJGBzdfZDuq3maKl5KkelqvnUy/kQ0QRbM2Ppn38RuyNQ3ngRziNiUmRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kc0AXjOM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso69345711fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709048562; x=1709653362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
        b=kc0AXjOMhTIIjpR/zSVlShOiv70JeqMzv3MAz7GrKymHhSSYePl4CEcCSvlQyhEce9
         A46OQxNiq+/vLubE8h8MsR+rgnlwhqu94Sl1vQ3gCq/+gCP60U9yXpdhHrV/c5RE2IM0
         82JtZ4GQojirptZkyAwROsTKb78J5A1jw7G6da7GKVURmZg4sBnv7L6knSjMN8Q3g9vD
         nEQYb6OH55WH2pdQYuezhKTEuUOvR63NMFEUhbZUo+s8eWir9DdbFMrBLB4ST0yxa1ve
         T2j1KAOUQTNnDtfxW7lFOo0wxLKeBZviQQ307DGoRkDEEAS3y2UmYYFAvTrZn1QujB2A
         yRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048562; x=1709653362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFVX7ym+8pOLQrofDsYET1wFA9cE78XMpoBIE1UuzvQ=;
        b=k0lpQZnlxuo8IjpPfZq5H4n48eQ3xPuq6aQ60/A8tvOZxbu+U7iILcV3quN1dDRTmG
         seaBLKX+8cNyD5DVFv+k2LFsvTQg2vm+C38WHfFJP6iwKXGZf8fhG0/plNYPUf49AKWe
         nTmx0O3ykY0gbakoZL6HzZJS1+hcCZ7Z1R3Alb05nBElpVkV+JyqtwgnNL8rCkixEyBz
         QbbL9u7YyiToOo2kdTWSOBDl5AI2R0cqbNLq0TYVzHtPG70cD73XE9NxL9eXb12P3Fqb
         v9UMAKKwSqaJKSAscOZJJOrRa7cJNefyxGR2jnyV78JtMhxdeQCDvkpv5HyRZ6j/DktN
         C7og==
X-Forwarded-Encrypted: i=1; AJvYcCUcFpArkSRnQGGIeKiGJ6tbbbwmZn4mugwbAqKlA64IY6tRmpJF6ZqwV0/CMDjcTREOJLT07cRNY+D5L+5bVNnbS5Hy/TdTTmhKDGjc
X-Gm-Message-State: AOJu0Yx9sfM3FZF+RgLJ1vyd/kqIcKTPqc5rRA5vvUN0jocCn0fGEAlK
	C+8DG6AlRmlJ7vW3nQ3cN0Yw1j7wYp3yzP+C1YOxrJxvP6fga15rb+lyu850Oz8=
X-Google-Smtp-Source: AGHT+IGftc1nRxlo3NEGi5ysAyh+KdodU1OSoGzfpLdwuYTGiDo6VZbLKgDDSZW/zITdmPT8UNKDIA==
X-Received: by 2002:a2e:9215:0:b0:2d2:91d1:a72c with SMTP id k21-20020a2e9215000000b002d291d1a72cmr2858451ljg.6.1709048561867;
        Tue, 27 Feb 2024 07:42:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm8635353wmo.23.2024.02.27.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:42:41 -0800 (PST)
Date: Tue, 27 Feb 2024 16:42:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in dtsec_init()
Message-ID: <Zd4C7kztg-eBqIQV@nanopsycho>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>

Tue, Feb 27, 2024 at 02:14:52PM CET, Markus.Elfring@web.de wrote:
>From: Markus Elfring <elfring@users.sourceforge.net>
>Date: Tue, 27 Feb 2024 14:05:25 +0100
>
>Adjust jump targets so that a bit of exception handling can be better
>reused at the end of this function implementation.
>
>Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Nit, next time please indicate the target tree in the patch subject
prefix: [patch net-next] xxx

