Return-Path: <linux-kernel+bounces-143251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2E8A364E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A412128574C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3914F9EF;
	Fri, 12 Apr 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZSsuj/Ge"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC60142E78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949971; cv=none; b=cwecX46rw744kLX3utqcnCUQRFvlp5PjQ6cLd1hrMzl/SfxAar/hJTUcwLIeJrrMRoRX4TghN8gbSlMafvAUo7cJcykx7J6cUycfmv+bkd5dkmUunzfNOPXyJULAf1qm3ccdu8Rr7FujrQzciCX/GG7JVuDCfWFDIZ3700LkJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949971; c=relaxed/simple;
	bh=eYKYUnIbe4yAEfAMfbPFL8XotCy/MMB0Onhvc8YTN6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLoYTYbsjSofCkirZXLJrmqdH+VmAAAPyXMGJGwV5j3mEU5bkQSmS6bPMxGuFlQcGC9S2zF0sa38YK1g4Ugn+J8aEjZUpG7NPFUYa8xzqNBUQ1nakTBvSkJy7pfqB/f6DVjqt7+32IOAiZAYUZWMUkZNBpvgQTp+FdUvMWa+5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZSsuj/Ge; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e45f339708so2993955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1712949969; x=1713554769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps+47mM0+7BT6EQDFy0dqt8BKlRMH8/BPpupOPVP7+M=;
        b=ZSsuj/GeJT+mSNm9ULpVIlRwJA2GsZLFZkDGha+YFexJ/Hj8KE7Gy8hXnImGdbCmj/
         seyzU61yCv3HIXPo5oEeXkhWrw/knpCGG8RtJbqU5+H122bTUyn5wHnVKzKCVHKxgpd5
         +K3G0m4GvFu1LJ/+UkCueQTYECRCuVHtwOfupTk5Suo8i4L2v91Wgoqb/cgpeepQ+TiC
         83CM6TvpkJUtYWKwYSM0UoW60yPbtuJYjNrigKd2rM5+b2ME2ne9SNrovE81aIod9gcC
         3iol3dvHZfGojlj1V40Gx3DjzsIZi5h4jbFtIUANBpHR0iclCIQVI1yLcV3SU02NuQhM
         njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949969; x=1713554769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps+47mM0+7BT6EQDFy0dqt8BKlRMH8/BPpupOPVP7+M=;
        b=uXVoj1YPDaIG9KX2ZLuJsKIMUm2BpGkDRKHnYoJ3OqW0egU3Mu1b4E9IsKIEk62gST
         JGhxvfYEDjxIwSEnV60Ano+1c9SDyvrr1U289qFBlkhG0XO/FoBXb8eGgVRqvHWNB2G+
         bT9i1Wl4/HhDPD0oTuAWl+kxTs8YvEi3vTFLcpwL7BalwjXrSPXF+i/T9b927JYuRAoP
         Sxjut/eFZiGEGHHPVkVI8vHKEFmR5hu8LfpXW/gzYwaUJi47R09lYN0UyBvj4d3RxuOA
         99tz0YzERmAioYOOeV4KtFdMETENOBV5UM/16nNaWgb7WqIYJkt++Zc7KZ8pRIPpoeo5
         sp6w==
X-Gm-Message-State: AOJu0Ywp5cEv3c/zfsa0xg3wD2iiKwAbV/9e4xcKBRymXCnpEZ1e5L8D
	JD8IqLNRPsY9mQhoF45RwWMAfpKZtdesNJGmlnZUyQI8PX7CW5hhHpzCZRszcTc=
X-Google-Smtp-Source: AGHT+IFuRd1V79mWYV4om7cs7u+T26j07zRGddRWY1Mkss3MCeVJr+N/0EpyaqgLj8HBxUfYiNSiXg==
X-Received: by 2002:a17:902:ea0e:b0:1e4:397b:492c with SMTP id s14-20020a170902ea0e00b001e4397b492cmr3861161plg.4.1712949968738;
        Fri, 12 Apr 2024 12:26:08 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.85])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b001e530aab374sm3336728plc.194.2024.04.12.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:26:08 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:26:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: [PATCH v2] kbuild: buildtar: Add explicit 32-bit arm support
Message-ID: <ZhmKzqxHXaSZmXee@mozart.vkv.me>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
 <20240410170450.GA1828262@dev-arch.thelio-3990X>
 <ZhcZCwMmANQS39s2@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhcZCwMmANQS39s2@mozart.vkv.me>

Implement buildtar for 32-bit arm, so the zImage (or xipimage) appears
at boot/vmlinuz-$foo, rather than at boot/vmlinux-kbuild-$foo, matching
the structure of the tar-pkg on arm64 and other architectures.

Link: https://lore.kernel.org/all/e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org/
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 scripts/package/buildtar | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 72c91a1b832f..86035c990aec 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -101,6 +101,9 @@ case "${ARCH}" in
 			fi
 		done
 		;;
+	arm)
+		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		;;
 	*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
-- 
2.39.2


