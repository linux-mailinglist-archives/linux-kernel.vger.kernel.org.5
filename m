Return-Path: <linux-kernel+bounces-128688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36080895E30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFA31F23EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3E15E207;
	Tue,  2 Apr 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw5oMGix"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1915E1F5;
	Tue,  2 Apr 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091586; cv=none; b=PufYvvlrw0u5P8m68sBtk0QXhGaMXnHHBSluiIbjOR1rGy+MtFI8GhmEjNIRpOnX6tYHMsyTQ6i7+EXQ6ylvz+colppUDs2/U+gcf7+n6xQO5z8Yha9J+YFeIKQ3bafhi0VBiNiAFVFXOyBx2BrPV4r/oQokWR9vg22UdkwQa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091586; c=relaxed/simple;
	bh=nAOFCAedsf0hKd3f54Osliv0hXUk7LCjiOLBeBM2DcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhbeMvLruXPS6ov0MjFJNLyw8RrjbXA1/gUHZkL2YV9ubQ0QPuY9npvip0oh5ElKOyiVLGWxo1l/3UCUHOACiDzLreK396qr2wi7ngb1LCktbpHptvU0yYTy0D3SsCxbn5dgsi8/5LOaHn7mIh4juZuOyc4erh9/9Nw8+/D9KTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw5oMGix; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0878b76f3so2499965ad.0;
        Tue, 02 Apr 2024 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712091584; x=1712696384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+K9JJATGbeqkgwim+AVY7UCJMuhkOONoGwaNDd6YxPI=;
        b=Kw5oMGixNhLqKkreD9rRYn3dLx1WFF7VK1xavCyehsDHhh0Xx7n/zFh82/gkekiGQN
         XN1ePpMFEV1zuoHPja2JflYCMg91DJN/HaaCTPD5USXgeCrhT6ugZ+esSC5sT4KmADsw
         7Ya+bS3IYloojpFlKm7eRw3S5YKe+DM0f5gl8YGZImYEh8I1dmUqHZpTHoeEnCg0NVKe
         wdBMpHLSeCZ41/trOre43dJ0Vxz3SKyantoCjSKN63b8cYMBErzzuRNWEk4F4crFjzvG
         hEaO6r8Sdq0m9RmMd+TuS48j7BSZvt935c4mlnDoB1/rLNsGggnJX5J6j3dEUMjGUjaq
         pzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712091584; x=1712696384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K9JJATGbeqkgwim+AVY7UCJMuhkOONoGwaNDd6YxPI=;
        b=mavcwJhk7NlkciROLCMvmqc7b+rWlOLf2tldIiPKfQYe3NI2WHToLmFvflTXk3RygT
         iXX/k/ax/lOtGCj449lk2C2TG7kMQY63Hov6IhcCNfW1scM9tlmT53n51sIPrudtzP1f
         fW1oaEWdGlxDopcUYi+kKTiLIiJcTB5CkGWK3x4gYFWxLqZGlJF1ZYKsn/zAe/n7CRG2
         5k8Z7VIcPCLl7FHKsj84Pvqbd7V5vWcSKeTZfYncyarXyRkDP1zRegnKRcO3h06LMi4W
         UyPpfBoiuK1rY1gwCJCzcsZhSewV3yA97XWwI1/cO8zPD05OjlAYgrCuWq96uTQJohmy
         +Sig==
X-Forwarded-Encrypted: i=1; AJvYcCWH/0iSCtAtLre5TjjyBs5qaxtnHcd/O3iZ5m1tSITSLmO+VMRn7xMTlEgom/UEVTWrHxNh5hw8VEs8mW2bdHZn8cllvfklj4UXMGm4ExQvGflLymmSa7kBPcfzzbBDqxrfpRO/JpzbGoI=
X-Gm-Message-State: AOJu0YwvNoZb9GYVDwwv8Hux4cIEDuKXSlsqX6VJSegeOFpWEUBOGobR
	i3i25Ah5KU2u5Q9+hPBrYqB00jAMPPymgM9vaYjYYp7FtUIw9tYC8tEyXbaK
X-Google-Smtp-Source: AGHT+IFcF36ce0k1X0uxMrgkvTrl1ppGOROpkKv3ex7DPNIDx1zuW6Ch3Cb1diKEpc6lOexHsoKQmg==
X-Received: by 2002:a17:902:c412:b0:1de:fdf2:b483 with SMTP id k18-20020a170902c41200b001defdf2b483mr926879plk.8.1712091584001;
        Tue, 02 Apr 2024 13:59:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001defd404efdsm11665292plh.13.2024.04.02.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:59:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Apr 2024 13:59:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: label vs temp%d_label
Message-ID: <fdd952dd-2f3c-4f66-8e73-68f1dadde237@roeck-us.net>
References: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>

On Tue, Apr 02, 2024 at 08:24:37PM +0000, Chris Packham wrote:
> Hi Guenter, Jean,
> 
> I've got a requirement to add some meaningful names to some hwmon 
> sensors (LM75 specifically) so that we can provide some indication of 
> where on a board the sensor is located (e.g. "Intake" vs "Exhaust" vs 
> "Near that really hot chip").
> 
> I see that the sysfs ABI documents both "label" for the chip and 
> "temp[1-*]_label" (as well as similar fan and Vin attributes). The 
> latter seem to be supported by the hwmon core but I don't see anything 
> for the former (I'm struggling to find any driver that supports a 
> chip-wide label).
> 
> Assuming I want to have a label added in the device tree to a lm75 would 
> something like the following be acceptable
> 
>        sensor@48 {
>          compatible = "national,lm75";
>          reg = <0x48>;
>          label = "Intake";
>        };
> 
> I'd then update the lm75 driver to grab that from the devicetree and use 
> it to provide the hwmon_temp_label attribute.
> 

Have you tried just declaring the label property as you suggested above
in your system without doing anything else, and looked at the generated
sysfs attributes ?

Guenter

