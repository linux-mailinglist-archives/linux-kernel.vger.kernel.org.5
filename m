Return-Path: <linux-kernel+bounces-128649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F5895D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F83E1F226E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A215D5AF;
	Tue,  2 Apr 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cSDz+lpe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E81E49F;
	Tue,  2 Apr 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089300; cv=none; b=FNlFLc3WfkMS+r2Z7pRlDAmjpw4NJKE+/7b3L7QPYIkplhyZV3Uu19FOtHqyyREEUzYiCpK5x6HsZ0hIsI89DvKCrPALBdJsSA0UBHM2nazuchI/wqInRkAJ/aksNrm8ZTKp6NeT/InQc61d0W52vqTUKqhgnpWuQTuAzHmX6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089300; c=relaxed/simple;
	bh=e4jnAYd+VY9lWUcL61nGpS7H9+W7B6UDiTDlwZgRiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNqSXjBf74E1x25wdcai69LLFMrP/R08yr1Ow7gBp+h07231swsr6KX1Gdg7D+yuoXPi103CAjCxF5FfFe6Oih9i0aRp4mde30HypJbw7kNkUyxWfpMF3fd2pff3UHuXA3a9T7gMoAIghAvOlv7xE9YTpMFA00GeFhDAghoUUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cSDz+lpe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C9F040E019C;
	Tue,  2 Apr 2024 20:21:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6wNlYm-goBfF; Tue,  2 Apr 2024 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712089291; bh=Hmf6dIpTeeQcjfFBgvmtyCkiDFGG8/EDjZNVlEzRMk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSDz+lpevVFi8ruEs/DA+EzXdG3OMXVUlJxAhw3UvWGJlPKZpsdlBDujSY4L+LfDP
	 epkuowPDPCXZHGI2ooJw6MDdMMODbNw1l4LiNM1XkSROvUhJu4ASNzhyENoZOJ+NOA
	 l5OiL8pLAqjpzLkUIADDBNef7TDkEFf/8Ezj+o5DZzGkPaL9OR7MffQ3MnrzadS0ZK
	 V28XPHbdaexpkQRdNrlECGIUpuLNVAr7BN9k8Z1xywqVDq6cisPVG/7AKREi4eJCkD
	 g4IUOUji1kAj+ZFSzYcySyOOJdLU+7sYqyERql3VLQURdXtYF1CD7ZYLV1QO/TooEN
	 Jk4vDuOmCF4u1ce9b4MH9UP8ug0M9utdHM6/MdWvCWChDNOUVSRVdn6poLMqZgrCPN
	 vmUlbm8xPEFp8icDhmllzq1p6VZy/fFhGbHwHKJSy8Rxu0pJdU30JrUU1yYsms+7Ju
	 NgpFfb+9xJSOOEBdDLA32YaKNWrv4eMrHzzYaIUP09g7EMzosIU3/QjmVfhIyd3K10
	 cXnB1XksIhhd419wK5Myuxs2Bd/YWj7DOHDg09416WzyBOxPSPPsV29+LQqSP2+m6p
	 phk03WSiwsGmr+qsBJv0LQRgMZHKUN6QZuIecumWf9LqCvKpvV7EtAbLQa3/nLjiAH
	 6RKN98d/50o0Zm5McAw/HW6o=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54C7A40E0177;
	Tue,  2 Apr 2024 20:21:24 +0000 (UTC)
Date: Tue, 2 Apr 2024 22:21:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
 <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>

On Tue, Apr 02, 2024 at 02:33:44PM -0500, Kalra, Ashish wrote:
> And we can't do this in snp_rmptable_init() as e820_table_firmware can't be
> fixed at that point and by that time this table has been mapped into sysfs
> (/sys/firmware) which is used by kexec -c variant.

Well, you have to do something here because if snp_rmptable_init()
late-disables SNP, your RMP table fixups are moot and invalid.

Which means, your RMP table fixups need to happen at the *very* *late*
step after we know that SNP is enabled and won't get disabled anymore.

I.e., in snp_rmptable_init().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

