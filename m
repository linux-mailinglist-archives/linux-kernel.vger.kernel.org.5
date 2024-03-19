Return-Path: <linux-kernel+bounces-107479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90D87FD19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E679283B39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162AF7F46B;
	Tue, 19 Mar 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffo2jhky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046B1CD13;
	Tue, 19 Mar 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848706; cv=none; b=jI4LUcwpQNUnBlRTINzPfP+s+1WIZRi7oyQTSkIGhoxFlD7sf6C2xPCbaT7rpn7+agYxFJQ96WRhSkv/6R0+jkzbD50L9iSAnmHdaDHZWwATDBTqqhAwEtuh0ZeDcDOnK4OikUsIGToB3tsU1x0oIQMx/SSrArfVAqq97z+igWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848706; c=relaxed/simple;
	bh=AxeUdPNBYbJRx9HhDpzLSa8ehsc5hQeqodbcV9lhIAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NipV6QAOrOX1TT1AWxn01Wth7VaOIeeOY5Q8Nv+TcHjoA/HzAmpbkivlSa+CdQHtpCKmMK8np1FIHC7b7lWOmLuErw/OB1YfYS2+Fe17paJd45y2Ci9fK22NZgYES3jcF8CkZ1SLoWk5EkbW34tOlpfk1nR3wBDySuWcpjHqyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffo2jhky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28A5C433C7;
	Tue, 19 Mar 2024 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848706;
	bh=AxeUdPNBYbJRx9HhDpzLSa8ehsc5hQeqodbcV9lhIAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffo2jhkyfV9prHAtrirt0gjJCvn0tvOAo6ghM0orDW42E4rKJNCgHhdZCJpk8PB/X
	 alUe5f1yLMv08OzLRokbVIsa2J2U6Ja8MzoQTpzvKmtlYZkI5IWOl/B7wD/KhTg23o
	 MYgtoVHrOxWQ9IYH+sfxtw8KMM/s7RDW8sdw4VPKJM8Rp5+kuNZs5Mw/59a02ZmREL
	 JkQYmCG3pxsE+7pleApScDFLb0EcyjSvZAvrtme76JNejc3Sxzq5Wu71ocHMe3/nkn
	 y8utWiPxwFOStbWoFchjIyFHqYiQAHrsZNaK04bZgb+k93lpT1N1wew0AMNdeceR4j
	 U5RN34DwsUBaQ==
Date: Tue, 19 Mar 2024 12:45:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	dlemoal@kernel.org, hdegoede@redhat.com, cryptearth@googlemail.com
Subject: Re: [PATCH] ahci: asm1064: asm1166: don't limit reported ports
Message-ID: <Zfl6vVKtGpC7-z1w@ryzen>
References: <20240313214650.2165-1-conikost@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313214650.2165-1-conikost@gentoo.org>

On Wed, Mar 13, 2024 at 10:46:50PM +0100, Conrad Kostecki wrote:
> Previously, patches have been added to limit the reported count of SATA
> ports for asm1064 and asm1166 SATA controllers, as those controllers do
> report more ports than physical having.
> 
> Unfortunately, this causes trouble for users, which are using SATA
> controllers, which provide more ports through SATA PMP
> (Port-MultiPlier) and are now not any more recognized.
> 
> This happens, as asm1064 and 1166 are handling SATA PMP transparently,
> so all non-physical ports needs to be enabled to use that feature.
> 
> This patch reverts both patches for asm1064 and asm1166, so old
> behavior is restored and SATA PMP will work again, so all physical and
> non-physical ports will work again.
> 
> Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> Cc: stable@vger.kernel.org
> Reported-by: Matt <cryptearth@googlemail.com>
> Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
> ---
>  drivers/ata/ahci.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 78570684ff68..562302e2e57c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -669,19 +669,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> -		switch (pdev->device) {
> -		case 0x1166:
> -			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -			hpriv->saved_port_map = 0x3f;
> -			break;
> -		case 0x1064:
> -			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> -			hpriv->saved_port_map = 0xf;
> -			break;
> -		}
> -	}
> -
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->saved_port_map = 1;
> -- 
> 2.44.0
> 

I took the liberty to add additional information in the commit message.

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=6cd8adc3e18960f6e59d797285ed34ef473cc896

..and already sent to Linus:
https://lore.kernel.org/linux-ide/20240319113758.197709-1-cassel@kernel.org/T/#u


Kind regards,
Niklas

