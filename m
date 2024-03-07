Return-Path: <linux-kernel+bounces-95157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80D874A00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05129B20C4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B182D7E;
	Thu,  7 Mar 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gW+LiIMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9x+Oejp"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E780C1F;
	Thu,  7 Mar 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801071; cv=none; b=NVWgiL67RMxEBQtm/Z5hcUhYculAFhozX2N9Ks3sJ2GVRnz59PIUsDOeKpg7F4aBP5HoIzjSoh08ysENo7eGRpb+EUnpdn8qgZx3Jo1axB5qJ6uFzKR7xirIgxt3cL/b/jIfDTEl0bie1w0WGB5G/Jc9ViQGSFkD3y02vDrri8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801071; c=relaxed/simple;
	bh=TImqIAoJvStQdyHuXOudqUE7tZvk0JApfWvejmmmwpM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=p2+ZFc51lddYbywY6VWdF9f6HxP6m3Rirk1ldGK2qmn3Mqc4CB4jB/bZ7pHVJpF7PpSHhTWwfuLcMJPCfJZzbnCN7hYzUq/QlECp5LB0a7G+8KMKZpaNlBZiweOaAFJ6SqhCtU4XaZM9a9Fj4QYvi1u2Aq1Epgg6yo2suiKmrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gW+LiIMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9x+Oejp; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6F05E18000AB;
	Thu,  7 Mar 2024 03:44:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 03:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709801064; x=1709887464; bh=3x5EJge/Em
	DoFbef/njqgwd3SUh9kx0m4dgwsd9pvxQ=; b=gW+LiIMhZ5dX+1y2jIuxu8urAV
	I+94yqHIdHWJxG0UXkjcYfSOK6dQsSOi32Iv+aP7Jv5/JYJtlX6Y5i7goqvdlytM
	5pH5oDSV6mBMltpmG6VaGNsrWcuIA4ebtVZDEUoTyIneh7XWkqr6OYzvd1m+i/pd
	U9b90JwQgECo6EShjOk3WeNFU+mqUsAbjPHJ+E5EKY4Xn3fhanYASY54RzDB9T+L
	jumYGX8OD4uGLR5hDXLkrmXLYo3zegUM0FfiSw0CytA7jfXHG/Nag2EX7RC8ZM29
	P7z/fNb/NhuWWXmbYPHnL1L6azxhgE2vD1X4RmENlHy8M3DBh+a7scqE/Waw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709801064; x=1709887464; bh=3x5EJge/EmDoFbef/njqgwd3SUh9
	kx0m4dgwsd9pvxQ=; b=q9x+OejpwtxbInNV1pB+5UsW7B1Gw4/FdTM3Lrx85V09
	tdnjq2nB4gxHdPkLexUIzWthuucc9iHoAF90BtEFSoLKWf9CWdFkTdPQ3qijhNth
	Mj6amIrIcPhvwecUdxtRmy1ogm74ZRahxuuuedS+Pu6MjxqnFU91Qf96aDxvjFnU
	Yh18JOHQxwrluTDgkI+Bj+ANNzWuIWfmCtLSJAPLRPnsqzpJnVrCIRUnrx2pQ1fH
	eItLh4mm5V9ECSZAwNzt4q8IZXVkoDTvggYwWdgl41eSrwG/C2suz1RfEyOdmI7P
	b5g0/2Ox+LDS2ZrirDM+E+c8dkomK51laVaVmgwV1g==
X-ME-Sender: <xms:aH7pZQRMTZnFz-kMyHV_9d4-GkQ2_djj4i8jWTM-XNQPbrPvngIyiQ>
    <xme:aH7pZdwR24tzB5RUIHDCB7PsVwoBT_PabPcsOyxqa2ingmIDh7Vg8Xl2hqGOK8Ytl
    RT4xwU0TXul7CpzhiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aH7pZd2agpRhZ7xsM1ATy3YKuwahGSz9xgCYItToeCPtFbApie4mrw>
    <xmx:aH7pZUDqXUFNDhPSfBf4_cs6UUiHfHtDnqKgZ_asrswjo97rznzNfg>
    <xmx:aH7pZZgBtuTvRxv0bmng63ucxota81RZhVR3D0hHA_s6u20_sf1YPA>
    <xmx:aH7pZaGW_1q3sGd-4J14uI4cgPzvA_M0NAq9q0f446gyEUjUSUDroLfb2fQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2E7F5B6008D; Thu,  7 Mar 2024 03:44:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com>
In-Reply-To: 
 <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
Date: Thu, 07 Mar 2024 09:44:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Haibo Xu" <haibo1.xu@intel.com>
Cc: "Alison Schofield" <alison.schofield@intel.com>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>,
 "Zong Li" <zong.li@sifive.com>, "James Morse" <james.morse@arm.com>,
 linux-riscv@lists.infradead.org, "Ard Biesheuvel" <ardb@kernel.org>,
 "Baoquan He" <bhe@redhat.com>, acpica-devel@lists.linux.dev,
 "Robert Moore" <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Greentime Hu" <greentime.hu@sifive.com>,
 "Dan Williams" <dan.j.williams@intel.com>, "Len Brown" <lenb@kernel.org>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Chen Jiahao" <chenjiahao16@huawei.com>,
 "Yuntao Wang" <ytcoode@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Haibo Xu" <xiaobo55x@gmail.com>, "Anup Patel" <apatel@ventanamicro.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Evan Green" <evan@rivosinc.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Jones" <ajones@ventanamicro.com>
Subject: Re: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in ACPI_NUMA Kconfig
Content-Type: text/plain

On Thu, Mar 7, 2024, at 09:47, Haibo Xu wrote:
> x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> would do the same thing, so the dependency is no longer needed
> since these are the four architectures that support ACPI.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..2bf47ad1ec9b 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,6 @@
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
>  	default y if ARM64

Can we remove the prompt as well and make this a
hidden option? I think this is now always selected
when it can be used anyway.

If we make it

      def_bool NUMA && !X86

then the select statements except for the X86_64_ACPI_NUMA
can also go away.

      Arnd

