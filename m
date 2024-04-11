Return-Path: <linux-kernel+bounces-141668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF58A21B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A171D1C21388
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C20405EB;
	Thu, 11 Apr 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AKnfTKbK";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OaXa2/Gd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qZZ16iPh"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8961CFA7;
	Thu, 11 Apr 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712874141; cv=fail; b=GX9p4d3V5UitUm4IyfspDySNbXeyelZGnf85VUqvhXkR40yHqxuGAxxz7jiynaV0QRnxafsmClqrPGI3XzLoCchdCEXgTv8K4JN0MoEBP+OdyW61lI5430x1VByCdfpbfQa7dfPL72YlPXjnhURVIzunhdY+RKqkBhtjmtRVDDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712874141; c=relaxed/simple;
	bh=egkoqwBsihTjUWAgZFHP5FPfQTPW10ImyFyEebwN7Jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ndZ0MsLzcKKFzUJ3yThbKUPB3aO8DNi6HiX8cX7p7LKm5ocMIqx99a4Y42+PrqB8NgfHZC73xjp6HeHQ7Hz3dv2YWB3ipFdVcaUlUgrqlKE9m9imkWQQFzy9BROhSqklcfUyFSlIFL0nH8Ds7svKjgeCuKdj14aLFXBdexKSEr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AKnfTKbK; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OaXa2/Gd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qZZ16iPh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BIR7FM001636;
	Thu, 11 Apr 2024 15:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=egkoqwBsihTjUWAgZFHP5FPfQTPW10ImyFyEebwN7Jk=; b=
	AKnfTKbKymSJJSfY2ffaf3Z7OZgEblJ+QQML+Ud3fyyVHPiPwOYh9bR24grOMgCQ
	IhahlZKVdiWpyGGDn684Rjqjy5NZ9X5CjX4qZ9wVxuNflYefxe+wZ3qP1HsUtQGh
	qcxLcmT6V5UHRivH8GrlFZPLIi4PiOe30ldcSqMLwqrMEdWbi16aGkX2EzB+b1p8
	DfTXQ4tg9xEd2ysnQJM1R03/fMM/uW2kZF6GpRlJqNTAzwwA9kbIHCH8Xd3bBi5D
	I7OUn+vaBWoSoLl9jpoPb0RwcUYjqyn0iAmGBsBcRt2g/cb90mqHfwpvGC0m5mqe
	TZ4c9e4tjUONBuvkpvks5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xb51dcr8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:21:59 -0700 (PDT)
Received: from m0098572.ppops.net (m0098572.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 43BMG26b013946;
	Thu, 11 Apr 2024 15:21:59 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xb51dcr8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712874118; bh=egkoqwBsihTjUWAgZFHP5FPfQTPW10ImyFyEebwN7Jk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OaXa2/GdewYv/K712CVUhfRj3AR/vIdEmjJNa7k7e/FBlHt1KQS3OfX9NQ6UhPEbU
	 SvNMLkTU+rXtvpOH9T8MlnznSMG/08hbSZ9V924IFsi/vgTi8WPKN9Yme/hWW0csXZ
	 HaGetEsDJ/PcycBwqlEdrcBqXLt3bP2EpcPUzU8JV5eb30ATriA6LSBJzbv3ndtboN
	 66O2H5aPoer7OEBtNXbef8EbraU3dNuLLC8I3nAJXyIRq4iTh70ECKnY+P4s29ChYy
	 6RB6h0gp8KlOFur9T2RAqZIJvmtOP/R6KRUnSceBCz5dw/Yx5hjm+NsLlyKVgzJM2g
	 WFwwBXH1R2Uew==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9AB8C404AC;
	Thu, 11 Apr 2024 22:21:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8908CA0069;
	Thu, 11 Apr 2024 22:21:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qZZ16iPh;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E7A5E40524;
	Thu, 11 Apr 2024 22:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bibLz4HvONqAzJyU41TsVeghVSop+4NVTCmEHhLjHjy5AeweTJm5cKBJk1jKExJCuT3mqjjFXZEGc+SQ4hPtWFQbZsJcfa7epd9Faen9BSQq/URI6+VFJz5rH4UE5jon6u+3Wt4p8pG+JxpCJtcNOfO/XJn6iGDcYUkywdDXWNYhYQCEuQAhp0haUyzhaFxs0vbvm4+nqENq000kRyUnWO5mPiB6sB8GfLwFTT6ruXzS+BYZXZk2Ai8OME5+ovcb3lbHul6eItO9p029i19hm/ZJQrY2JiBeeEHUyKFMa6i8RZlCNjohhAmSLTGjYrBLDZN6CP/yDHEXzltDAEXQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egkoqwBsihTjUWAgZFHP5FPfQTPW10ImyFyEebwN7Jk=;
 b=eZJRqxwB/Gk5vyZ5uwX/ELB+Wx57B7AQ/DNRcbIwbTgm7JmIDm70o3FPCF6xpL8Yj2l0j1d33nfZT6HKbQP+bKVMPi0XxA0u4BoqdFYWUc/0AK4Qt+1X8Pm/ZzhAr7O50aOa0ZJXRMFelFq7qaBrU9iccFE2JHQX+FQnbP5543q793lushcAqbJALrqckL6YdEOXq2C0ikxnoLjGIa8g3Z61VSxchJa1rRMkw28X9qYHfo5F1f6qjuIrnY4xtrZ6n2QasAn3emHPGjo8EVJBdaCFF3rxsvkphBUHWdNNBQuA7BrbZbxme9L+0i+391QuGlSS+XKNvcE8DeC51tWv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egkoqwBsihTjUWAgZFHP5FPfQTPW10ImyFyEebwN7Jk=;
 b=qZZ16iPhzHpibDZgL1y3oP5IVl5QBRdJAZthR0BkGdK4FL96FwEj+sVUKkrSE+1kVzeFYSuuxNJYkzYsA+X/qGFUQIZ9U/ZaxllWV2BlrLrbmB31EDr75chlQPNZuRtV6piRU4Fhtfxt/gFgJCJCiXExefudNgrUjN9Cy8vt3XE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 22:21:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 22:21:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Topic: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Index: AQHahl/kJDrJTmdr+Ua3V0pkAR86KrFfNPmAgAHK9ACAATBTgIAAjNqAgADzbIA=
Date: Thu, 11 Apr 2024 22:21:47 +0000
Message-ID: <20240411222145.rkjz3cfzudjfnkdt@synopsys.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-7-linux.amoon@gmail.com>
 <20240409015352.ocpjbgxrx636jmk4@synopsys.com>
 <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
 <20240410232623.6gaupt6t725hhype@synopsys.com>
 <CANAwSgS-oD86obNUHcjAwfD+3v6VyWidTezwtihJBOC8VWHPjg@mail.gmail.com>
In-Reply-To: 
 <CANAwSgS-oD86obNUHcjAwfD+3v6VyWidTezwtihJBOC8VWHPjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB6798:EE_
x-ms-office365-filtering-correlation-id: 8282292e-d20e-4abc-ce1c-08dc5a75c72b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /0lOM2NZDoPuQQ0FEqIXgQvCRtf4lDOoK66Mhe9ZIa/ZpODUftNKuOH4CJk4JkSYGt8qAf7AYWbUCwDs2QlnC/ZrMo0/wZvyAbTSuwpHFMP/6iiGLW9B0jODgI1sKHbu1IrApZn650ubFG15FaKfLHjlKKIpxNXZvyFkfvYytvmxY6pm01f67aiGiVWE1K4Y5h57+chMJq1h3orRVyILxZPpkTR2N0dxEtgW0ZE4TJsTWIPYblRQVr6GMzm3duwCL8kbo9ERTi/A40Jrw1F5w/yi+wadWsZpakrr5+dJ6RSIoq3RR2LCdx9WjsF6VHWVxhoZQ+x0dG6VAoqh1rtYoZrhp3DIVkxMEMNuRvfE7QwGxmyIfhJgBeLgr+sWavYrRXZVAdghD95mIo/FNOZZqO67qqVllaEhLzaCmKTxPkHCDNN80GxzVeB+cK1PHntzpvgfGAaFrq18oPeMf8dZzZemlNWwvQ5hHECU2FEUDj/bREstnENVy/dB28k2DoYCE7asCBHymGNqG9WmzenW58b4M4sAG5bIhAkMT24LCdrexpoOQZ7uDS8K0IL8s3KNxJwz7KyG7uM+MPCsqlC2yYaC9W8bH8/l8/U7DLxL8FSP4XL9LrGhTDTB1Jw1p2vq9NDsRbrL8dwWc8J6gzeri3CdaXte3g/HkSethbHxN8QyYleYetqSTx01HLV7lL9PuFdPdc6EYkapncpwxNn1Tg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b25lNXRBSS9SbmQwL1NaZkcyellyZE9keHZCSHJzZDRnQytvZHcvT243a1Bx?=
 =?utf-8?B?WEh5eXJHSnZUYXF3L2EycDUrZHREVGpsWU9pTkgyVjEvem1vTmpMTWlNWFkr?=
 =?utf-8?B?K0VIOTFWOHkzOXhiWFo5d1NMd1F5NjdFNGxoOXVYUmFFZGdzZjgxdXc2QTVP?=
 =?utf-8?B?MDVhK0tRcTAvcnN4dTVqY0VwMlRLWTl0R2c4azBVU0l5cWdjeTU3NzVxbEhJ?=
 =?utf-8?B?RVMyWFJja0RJMGVZWW5GMndvUUtlN3hQU3lQckVlSkZaSDhvY2w4TWJvS3Aw?=
 =?utf-8?B?WWVOWUo2N2p0Q3JPZTFGKzA5KzZFSWYwSVVMSnNYaWJqR2luWmQyQkxiSkFl?=
 =?utf-8?B?OWM5S0VheVUwcVpEV3RqeE1lR3hURGtqVjZkSzhYRHFuRjBCRXkyTmhXUXlS?=
 =?utf-8?B?N3lzQ1dqUm9nMHJwUExaa3lSaSs0RUpGSDZuaDNjVE9uakpXUEFHSTR5dVYz?=
 =?utf-8?B?VS9HUUEweW1QYXMrbFhqci8wb1k4UkkxTzZLSDk4R2U0OCtDT09GeUVYamxZ?=
 =?utf-8?B?TjZaK0ZTNWtmMmFsejhtVFBkRHp4VmNDQlUyRDllUU02ckRFTVlPNERuMkdR?=
 =?utf-8?B?SThmRzdNZVlva2hMSC8va3dwWmV2LzVxME5McHVLU2tyTjNSMVdTVGIyOUIv?=
 =?utf-8?B?b25icXIrWi8wTWVRMjZEWWxiczlUQStEVGFMem1iZEFIa0Q2Q205V2ZqejJx?=
 =?utf-8?B?UG5DclpNc2krSkJEMHlFcnJBZTgwWGQvODd0VEllRkhMS0tPTnJ5MVVHaUhs?=
 =?utf-8?B?RWRTTWs2Z0U0KzVIYWJpUDk5QnBpbzBPRlJHUnhHbEpuY1hpbXF2VEJnb2VJ?=
 =?utf-8?B?L3VWalh4a1VPQXV6a3JjMGlNVW9vYUVHRUlWcW84eEkzbkcreW1nOTk1OGhW?=
 =?utf-8?B?UGhyRlBwalBhQmtLT3k3R01sM2RCbmt2Q1VyTzlTcW1EZy9uK2k4N1E3eFJt?=
 =?utf-8?B?UkliL01CNmFEbXh4MHd3YSttQlk5SFRWZlYvcGkwOW9jTExURE1ncHJUR0xx?=
 =?utf-8?B?UThVZFhOdDJGQzQ2NFd4WXJyTjA3U1ZzdVU0NnpyRXNFYjFMMTVGRGt4b3pU?=
 =?utf-8?B?UWFON2NZTGFuV24ydlJMMGlBcDRTR05iK3hsMEtMc0p2SERJMlZ4c1YvUWVI?=
 =?utf-8?B?SzBMU2VwbU1FN1ZHMWdRY1gxbmVwTGtUQWlTd2RKb1FCVHBFeCtESUZ5YnBo?=
 =?utf-8?B?Tm52UldwN0FiZVBEUkJWd3JLWXJZMWM0UHBJdk9WTGViM2VQTkIzTEgxZnAr?=
 =?utf-8?B?RmxoN2ZMMkR2NDlCUHgxbEZPaEhiZDc4Ni9Ia3B4dG5vRUNzQWVUMkFVSjZD?=
 =?utf-8?B?VjVtOEVjeVM1NXAyVG92S00wRTFrSEhUZ29aZEVJUGlENWdXUU41L2NKdDJL?=
 =?utf-8?B?NURnSmNxK29YSjNQM1F0V05jYTFQbjAxSElMYytURWRpcWt4b2lUUUU0ZmZq?=
 =?utf-8?B?SFhKNVBXZk9LWDRsMENmY1ZGcHVhSDlyOElzOUlZOFFVVFFZMmNiZ0NpZGdD?=
 =?utf-8?B?dzZsZnJrVGFGQzJoVTdhTElPVVFKZElNWWNwVlUyMGV3UHVYMExhcmJIcHVh?=
 =?utf-8?B?Z1B1V003Y0RmV2dJVGptQ2RsSHhyaWh1OXF3Tmo4dERUWDRjN1UvbU85ckRo?=
 =?utf-8?B?Qm1xNGRvQnVzZUhmM0l3MG14cyt1Y0ZtSTNTQWx1bkVSczVxajRZVnVkVStQ?=
 =?utf-8?B?VWJJcHNSdUtBM2gwV3dvYkxjOGZ5aWtXb3FjdzJrd2l5YVhXT05ib0c2Q2ZU?=
 =?utf-8?B?SVloZkRkU3FCNVVEUThOZWJnNERBOG0xQXpjYTRldmNrNy83YU5yZmdLQ3hl?=
 =?utf-8?B?UW9SQVV2SGJ3RzdBUHJuREJ1a0RRRU93REVHNnZTeVJ1U1FVcjcrc1JiUUZN?=
 =?utf-8?B?OG5laG5Kc0FsaG9WclRhc084REdaZTZVSHNNT01ETjVuRFQrRXBkcnpOenZj?=
 =?utf-8?B?VVBOUVR2a3lCa2NiMFRQQkZweXFyUWExeVZjY2J0NXo4T0JnU1BSTmZWUXh0?=
 =?utf-8?B?TVZOWkwvbU0vUWtaMUg3dVlGNHVsdDIwdUN6bmg0OWkrUWxBU1dhSlkyMit3?=
 =?utf-8?B?YmYwZCsxUXpxMng4ejl0QmtHckc1VDBoM3lJMlVoaHJSSHZvS04vMElaMmJS?=
 =?utf-8?Q?YoETe51Pwt1hhOqtxtOMlsJWS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34FC2D1CCD175F49A4FEB6EC83A17A02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J3D+XdPBoD7jJbmokWTB55B6Yr5F0EG8qx4MdCvXxO8E3Up2FHKcGvGoG5MSbmf+jurblAJXpF0Sv8+a/0h1pO9uDXYRQ5UskXqgkr5dMZ/yIAvsGdlLQckkf8A5qcR8QHRQUbVZ3Rr9bwiTUVzr8bt57rqn6o8xCyr4DdBwIf/+oWPK5Dzk3y0wn66b+WstTf5VFucWETP4VUcSaDinPlIoBfTH2v76pKN38IufOOm6Mkg+agaQyNnSdDP83FFQu7xYNuFpROaW8ZY5nZ4M6zmaWvqtLxRNg0tfPqer0kWPCPgh2QlLQKos9Do2opRCTefVGMJp6qCQbPxEwYlDrPXq1OUfOYafjX/mVPHCqzH4wk0+HGtZJEa9SRVzLrFQ8EgeFftTK5SVHg2jIPDg/+Oz1HtGebxMDWOF/93xj1RX+lwBkLobM6YuYJcEfZbZuH7qm7uyoFpBDHVfnmTeoUOEVaFab8ZBEobaac6hXJ1dVtX11JqloppmSusE4WJIrVOdcJtIGV3pyMa2xTlewZl373ngD33dm/1MWHSCvVCkY/hXT6HBINzAU4BzPPTohe1mcefQ1ReZW+T6tPKDKEcdT23Lz095qdbJuNLdoQpRirZYwe51WQYeKgLUdhuQJsMi2Sg577N85gstynDAEw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8282292e-d20e-4abc-ce1c-08dc5a75c72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 22:21:47.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5WtogbZtfyEwKBqyCvzrFCiraLDxsvkG67Z8eSCYfaSFwmvBgU2vZTJ+nTOns73C6d45Zn+v1syAz62cwMItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
X-Proofpoint-GUID: d7yOG6zw7IaX6UiBs6BtobquNb9-RTD3
X-Proofpoint-ORIG-GUID: esoCFtGSkb92w3UeoE9jaSWTCFDnzjc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=894 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110161

T24gVGh1LCBBcHIgMTEsIDIwMjQsIEFuYW5kIE1vb24gd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiAN
Cj4gT24gVGh1LCAxMSBBcHIgMjAyNCBhdCAwNDo1NiwgVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgQXByIDEwLCAyMDI0LCBB
bmFuZCBNb29uIHdyb3RlOg0KPiA+ID4gSGkgVGhpbmgsDQo+ID4gPg0KPiA+ID4gT24gVHVlLCA5
IEFwciAyMDI0IGF0IDA3OjI0LCBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIEFwciAwNCwgMjAyNCwgQW5hbmQg
TW9vbiB3cm90ZToNCj4gPiA+ID4gPiBVc2UgdGhlIG5ldyBQTSBtYWNyb3MgZm9yIHRoZSBzdXNw
ZW5kIGFuZCByZXN1bWUgZnVuY3Rpb25zIHRvIGJlDQo+ID4gPiA+ID4gYXV0b21hdGljYWxseSBk
cm9wcGVkIGJ5IHRoZSBjb21waWxlciB3aGVuIENPTkZJR19QTV9TTEVFUCBhcmUgZGlzYWJsZWQs
DQo+ID4gPiA+ID4gd2l0aG91dCBoYXZpbmcgdG8gdXNlICNpZmRlZiBndWFyZHMuIElmIENPTkZJ
R19QTV9TTEVFUCB1bnVzZWQsDQo+ID4gPiA+ID4gdGhleSB3aWxsIHNpbXBseSBiZSBkaXNjYXJk
ZWQgYnkgdGhlIGNvbXBpbGVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
QW5hbmQgTW9vbiA8bGludXguYW1vb25AZ21haWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+IHYyOiBhZGQgX19tYXliZV91bnVzZWQgdG8gc3VzcGVuZC9yZXN1bWUgZnVuY3Rpb25zIGlu
IGNhc2UgQ09ORklHX1BNIGlzDQo+ID4gPiA+ID4gICAgZGlzYWJsZWQuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoZSBjb21waWxlciBkaXNjYXJkcyB0aGUgY29kZSwgeWV0IHdlIHN0aWxsIG5lZWQgX19t
YXliZV91bnVzZWQ/DQo+ID4gPiA+DQo+ID4gPiBFYXJsaWVyIHZlcnNpb24gaGFkIG5vdCBhZGRl
ZCB0aGlzIHNpbmNlIGJ1dCBJIHJlbW92ZWQgdGhlDQo+ID4gPiBndWFyZC5DT05GSUdfUE1fU0xF
RVAuDQo+ID4gPiBhZGRlZCBfX21heWJlX3VudXNlZCBqdXN0IHRvIHNhZmVndWFyZCB0aGUgZnVu
Y3Rpb24uDQo+ID4gPg0KPiA+ID4gSSBoYXZlIHRyaWVkIHRvIGJ1aWxkIHdpdGggY29uZmlnIGJ5
IGRpc2FibGluZyBDT05GSUdfUE0gYW5kIENPTkZJR19QTV9TTEVFUA0KPiA+ID4gYnV0IGNvdWxk
IGdldCB0aGUgd2FybmluZyBjb21waWxhdGlvbiBieSBhZGRpbmcgZmxhZyBXPTENCj4gPiA+IC1X
ZXJyb3I9dW51c2VkLWZ1bmN0aW9uLg0KPiA+ID4NCj4gPg0KPiA+IDxzbmlwPg0KPiA+DQo+ID4g
Pg0KPiA+ID4gQnV0IHNpbmNlIHRoZXNlIENPTkZJR19QTSBhbmQgQ09ORklHX1BNX1NMRUVQIGNh
bm5vdCBiZSBkaXNhYmxlZCwNCj4gPiA+IEkgYW0gbm90IGdldHRpbmcgYW55IHdhcm5pbmcgcmVs
YXRlZCB0byB0aGVzZSBmdW5jdGlvbnMuDQo+ID4gPg0KPiA+ID4gRG8geW91IHdhbnQgbWUgdG8g
cmVtb3ZlIF9fbWF5YmVfdW51c2VkID8NCj4gPiA+DQo+ID4NCj4gPiBUaGUgd2FybmluZyB3YXMg
dGhlcmUgYXMgZXhwZWN0ZWQuIFlvdSBzaG91bGQgdG8gdXNlIGl0IGFsb25nIHdpdGgNCj4gPiBE
RUZJTkVfU0lNUExFX0RFVl9QTV9PUFMoKS4gTGV0IG1lIGtub3cgaWYgeW91IHN0aWxsIHNlZSB0
aGUgc2FtZQ0KPiA+IHdhcm5pbmcuDQo+ID4NCj4gDQo+IEJ1dCB0aGUgd2FybmluZ3MgYXJlIHJl
bGF0ZWQgdG8gdGhlIGZvbGxvd2luZyBtYWNyb3MNCj4gDQo+ICNkZWZpbmUgUFRSX0lGKGNvbmQs
IHB0cikgKChjb25kKSA/IChwdHIpIDogTlVMTCkNCj4gDQo+ICNkZWZpbmUgcG1fcHRyKF9wdHIp
IFBUUl9JRihJU19FTkFCTEVEKENPTkZJR19QTSksIChfcHRyKSkNCj4gI2RlZmluZSBwbV9zbGVl
cF9wdHIoX3B0cikgUFRSX0lGKElTX0VOQUJMRUQoQ09ORklHX1BNX1NMRUVQKSwgKF9wdHIpKQ0K
PiANCj4gU28gaWYgd2UgY2FuIGRpc2FibGUgQ09ORklHX1BNIGFuZCBDT05GSUdfUE1fU0xFRVAg
b3B0aW9ucw0KPiB0aGUgcmVsZXZhbnQgZnVuY3Rpb24gd2l0aCB0aGUgYWJvdmUgbWFjcm8gd2ls
bCBiZSBzZXQgdG8gTlVMTC4NCj4gaW4gdGhpcyBjYXNlLCB0aGUgY29tcGlsZXIgd2lsbCBkaXNj
YXJkIHRoZSBmdW5jdGlvbiBpbiBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUw0KPiANCg0KVGhlcmUg
YXJlIGRpZmZlcmVuY2VzIGlmIHlvdSB1c2UgU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMgdnMgdGhl
IG5ldw0KbWFjcm8uIEl0J3Mgbm90ZWQgaW4gdGhpcyBjb21taXQ6DQoNCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPTFhM2M3YmIwODgyNjZmYTJkYjAxN2JlMjk5ZjkxZjFjMTg5NGM4NTcNCg0KUGxlYXNl
IHRyeSBpdCBvdXQuDQoNClRoYW5rcywNClRoaW5o

