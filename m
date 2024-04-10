Return-Path: <linux-kernel+bounces-138042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A5A89EB72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC25C1F21FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3D513C90A;
	Wed, 10 Apr 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rt3EMoJl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fM1KpEHk"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287928373;
	Wed, 10 Apr 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732805; cv=fail; b=kBT1z8u2gX7oXZkzCcfNf3vlfRHSvv1CnBReMpL1hcMNwIg9Qtv0qtQJdleGtHmo9mvhPEPSNdmVyqXUx6l8f7ZbKt2EakVCrRc50kLj+buRFJj4C0H9UKxl0qQuEDctJuUlAAxgkIAFAc/IBJoJWvf8A4486jwi31hMIYWycx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732805; c=relaxed/simple;
	bh=Tf+K10IlRR7vD59EyE4FuIC6SEei7JtRKPGhknLgfVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hfi7wTbwPRJcgVL3RK5DDrSCjN4Rfv81pEP+jJL9vDth+DAZpb6s5VLADqIWAmk3wsZh0QAO2M8j4se/wsVy/q9T8BtCSa5DAv+EgSK+eVdKIvmkdorFevv1VtW9JV+KL9FZfN/DifTCqa6tuzsyeMoqDjxHYIhEh/xvQsDjhvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rt3EMoJl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fM1KpEHk; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712732802; x=1744268802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tf+K10IlRR7vD59EyE4FuIC6SEei7JtRKPGhknLgfVk=;
  b=Rt3EMoJle9o26FbPFhW0V7OewvKjaXSjTX3B8m6CW6Kna4J1leTex3/t
   kfnutalf6WMhV7i3asgTv332pReHygz/OY0oi8UWysKz4VKpJxr9nksdk
   bKLUTYxrjRKFh6EAt8x28PoPUI1zXKaDIWpGVO74LckbtqEn2RICa9uAB
   yVVRkmRAh58uCfo3CCcJIxFDZ9akVjIYiq0wTx72ImxwDbvu+edhDCiRl
   iKnoaI/wpO7POlgh3bRAPnFVwM8Q1oC2oxq73FMvIO8hBLSJtu4ivaKxI
   Qej1AZphM2FiYOGPnSLSC0+sKKpZVl4GpWRXZrQwQ9nLYfU1NQa+vam8i
   Q==;
X-CSE-ConnectionGUID: b4JwlG1pRw+IJYnCPXn37A==
X-CSE-MsgGUID: pIaQA5u6Tx2Xmyvx1OHGDQ==
X-IronPort-AV: E=Sophos;i="6.07,190,1708358400"; 
   d="scan'208";a="13906094"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2024 15:06:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAiJTQe5DHGUxrxP6k5pMXvBeYo+pZkbjfowiYRT095llL1xn/SLoQmadwYsTCFd/0gTIItcL/bRggFuy2Zv2GbietlJa4r/3+xQclxI4ibGJH7uafknyBVpC9RqDsL5Vva6b2imXJPkn+ELBtlcId6G+1VHAM/tjoYIPIcTlvfgMRiEoI7na6IAhViSQx2DU9EB2TzNffljKaTYpUF49OIIbLVmMQl25ybxSJBtsr+psYzlq6Qh9vfswktab3VQVMa4hRfw2Y6vaNdeUAwWYzKrNWDKX21O/XqRcqFxasKYExyGgTLmx0+mHz5kEUWgRJywvl5WWdWnr0Py/4qXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf+K10IlRR7vD59EyE4FuIC6SEei7JtRKPGhknLgfVk=;
 b=ango/qmHCTahUlr1w9pY1lMpT9V/bdQd8n77UXnM1BHoxak5Y/8wWeQjZdI8PXm05oLNIz5KLTEYoDO+/1QTB+cYO6Jcx/B7JOkvtC3tJNI0ZoOqVBALq3C8fV1LBZXJeiY/ZU0/LlEOYONq2crSMCw2l6CauFe5C2TPET4gRa2tK6UeIFTnC0CEfwcJEimKp1leW6x/+x5I2E63TzQ7ikkmyvWMm3YaVXJzTVxB/5Y1i2BKgVq7HAoZBOLPEe77TTYNjjR0k+Nu2UqjH+aAjrVPrq16zEO8mIyPRNZxscoGhftQocFJMDjEobJWx397p3MxnIHuRovVEA98YSSqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf+K10IlRR7vD59EyE4FuIC6SEei7JtRKPGhknLgfVk=;
 b=fM1KpEHkGOVTJXBMd8APO4UT60NoBhEY9RDyxLWrd+xH1pOpwf7OWiNsf98sEezr4an7R4XEmf8z7fe6rLDPkBMboUACMP6wxk45Vfk81/DtUXvuX1exBDDcmS4igBuYEXXUeJj0/DY3Z8GAum8s1XmxMaSziLefwAgV57vz1h0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7222.namprd04.prod.outlook.com (2603:10b6:510:1b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Wed, 10 Apr 2024 07:06:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 07:06:39 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHaiLFx8LxfQ5dil0mKLRXAtAu0DLFgmbGAgAB/P+A=
Date: Wed, 10 Apr 2024 07:06:39 +0000
Message-ID:
 <DM6PR04MB657551A7FAB39883B3D890F1FC062@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240407060412.856-1-avri.altman@wdc.com>
 <20240407060412.856-2-avri.altman@wdc.com>
 <37c51970-1408-4a71-926a-780c663e5572@acm.org>
In-Reply-To: <37c51970-1408-4a71-926a-780c663e5572@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7222:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 42LRwT3xBF2VXyOrbT+3B5PlPmMva+ShjDPe8fIZ271yWxZNrBopY2dR3YBKCtJfUjrLb+A/ec4dLyt7Qm0/Xy9+RjVxF/pgGO6ZTPHgXUgXgySgJuirvxrbpk4gL6M+I8yuZL7haEajuiV/7IPqjoZ1083KZxLd7TAwF2CBoPLuALI58xtc2bj6zLjJji2vJ7h3QcihetzphPrwFPQgFxmL+YCfNJW7qJcBtoTnkzFbCp8hlGYHrKFmA8fglj1NWuQWDwe510MNUAYcWietEUDUU1ughvXo1zySsUAktssTeJ7SOcqKhximUfxC8Z4+6fCijdFsFUM7KPmWuT6yZm5Zlj4mEPdFvZtPh67WoSIbdDqWLaaxzQhwX7FSeE9Mc5dl6ukVBmv0CYurm1gcF4LEsg7ObbmhwFWE/InO5ETOYFjHXBIV77BzLeQ+njx9GifdMy+LRkc+fbsaxi5u2PdCF2UJHiMxJrCMwb2BiCYmqE4pMdHJef1Kc2dqDt36VFw7qEkpbD6+a+eUs4/xC/gTtrU24RMhdJkcTZt4Ua/sO4UkT1hHsjUzxocb2prhrQrib0t9QEvuRvjm8Fo8D+155/TAxll5j5THFM+2BiRH4Bv6bbjdGskuyfmFATm2e6XFgdLYYC9SYPs6/KcFyXx7tAedLyAR9yBFlMLTU7s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkxMS0wzQ0hNcWRsanA2dUVLdjRxR01KbitiM0dIYnMyQ2dDTDBsZTdGQ0tI?=
 =?utf-8?B?b1ZtakhBRHV3YURreU5jYlNnY1BxbjVjeVh4aTVTVUlTN0t1WkFUeGlrc2Fj?=
 =?utf-8?B?eVBSZWNpdkF3eUpRQUY4OGRLYU5vTHFFS1JjejBwbWFFSHArdUZZTkU1VGVj?=
 =?utf-8?B?L3NXRGE3TG9kSEd1N0JvQmo2Y2pCejY4WTJJNGoyRENHOGw0SWJFZjJBR1RG?=
 =?utf-8?B?Y2dnU21BaElkUVF6bHZ1Z3pYOXNrZ2Z3MHRRSWJPY2lGeUpIa3g4VkxQTnhZ?=
 =?utf-8?B?Qzg3dlQyOWtxZUp0L0lDcEZRSUZNSnpLck1wNThCZFVVVWM3WDd0V3J4ZGZx?=
 =?utf-8?B?Sk9kMEUybHNlWjZ2ZVZWM0JRVGZ3MWdGNTl2U0UzQU5lWnZiUisvNWxLUFlz?=
 =?utf-8?B?VzdhWUs0eW1UZjhGanNUcmh0Szl3TkM5bGg1WUFtZ3laR09iNmlrTUxpVUpP?=
 =?utf-8?B?OVVRbU12RElvS3FQUE45V1ZVNXdRQWlnSDdpTTZWQzhXeTZDem1OVGROSkpC?=
 =?utf-8?B?ZXBsTG9Sdm0vM0RJS0JFMlZIUk03K2dRRnlrZ3FoQ0NzSFl6T3dweHB1bVUx?=
 =?utf-8?B?cTBPalhuNXZDS1U4Z3VUUkJ3aWlqQjQ2aktBVDVkWlBpb3Z0T05MdCsxbTlM?=
 =?utf-8?B?U2lCNFBuUU5VLzdhcmhEVUdUN2VlSVQxdExtM3BqYmF1YkpySTFBUStGRjhq?=
 =?utf-8?B?MzFSNVJ3OUdaSVRpMUhlVU80SmhtMExPWjJCRHc1MFdxYWZRaWI4RVFTeHJX?=
 =?utf-8?B?UEhDNy9JSHVGRVRyWHlxZU8xTGJTeWNFR0x4YUo0d2VZOEVuZ29oUXVPNDdL?=
 =?utf-8?B?TWJWZkpPRy8xaDZMbVpaT1plcGhPYmdlUFJuWFZqc2t1YndVU05VdGhSSFNQ?=
 =?utf-8?B?RzVTSUlvbWFDRDBLZ2RqUzZka29Ea2VQdlFWOGF5em9Jc2E1aG1naU5LdTdQ?=
 =?utf-8?B?TXFkdUJsdERMNHZON3YrRzVTS2M1T1BpNVlVS3oySnBOK3FoUEd4ZktHcVgv?=
 =?utf-8?B?Sm1aUXUyL3lXY1dJV3VTY3NxREFBWGZzS2d1QTB3aG5BZlJheE5TbFB3TWkz?=
 =?utf-8?B?SFNuMUJ6eW9rWU9TR0xWc0FxR0llTGgvSERrWTdYVFh0SE9qVnpYSjBDZmgr?=
 =?utf-8?B?cWhVaC9TQ2I5eTZHMXc1RmUzZVJWM1ZVTjVpcXdOM0UvNVNpaGhkcDluNkF0?=
 =?utf-8?B?WTNHdUlxTmNYdTYxb2daMW5ILzJhaTkyRmpKdU4rbHJMR0svR0JyOU1scm00?=
 =?utf-8?B?cXlITENuUWJwSERIZnc4aE9CZWI1Z1VaeWNpdkVKSjJRcU5oYU1EN1JjdVNN?=
 =?utf-8?B?NUw2RFJNT3M0WWFjdjZEWS91NGZjK0VNR25TbW8zTFdrekFIVmIxcG42aFdT?=
 =?utf-8?B?amNPZHVyWENDaGV3bVA1L3lRZ1Z3TXVpMlZBcVdQb0FIbkRqMFNEWmFaazJt?=
 =?utf-8?B?Lzk5R2YyVVlsVXZTVXd2NEhOcXBFb0VPQVFuSDZ3dnkvblpRQ3dpOUswYWpp?=
 =?utf-8?B?dnQzR1RDb3I5YmM4dDF1Nk11WWlobTVJVW5IRHBMbkczTE1sU3M1NW1YL0d0?=
 =?utf-8?B?QkMwZTRlclJ1V1N0QWp0U0RJaElQUy9hcytNc08vL0E1aVphTzJRTkRkNXlJ?=
 =?utf-8?B?Q0dENDVmTTJCa1lWbjVaWE80Zk1uZUVkSGhSNHJ2MHVkZTFYRlR4enlUTjBn?=
 =?utf-8?B?eVNsOEZEVkszc3pUWUIyN24yU2JXT3lCZ2d0L1JiTThFc2s0Y3I5N1ljOE5K?=
 =?utf-8?B?Mm9DdGZyeGJjNFdObGVyYzBVdU1IOXRDdFZRTHdQZjVGU3dqOXVxL3ZQNVBG?=
 =?utf-8?B?aDZBU2JmOEZPMGFqRENBK1orOTR4UVc0cnJrS1JxQ2RjeURiUHJtSEE4VTd5?=
 =?utf-8?B?SThURm5XTXMxSW9tZlh1M0tDUWFFbEJtL2hBdFVPYy9pQW9wTjI1VUFNMXVZ?=
 =?utf-8?B?TUFES0VCc3Y3UEI1TTZnQ0thUS96STRVTUR2WWlpUU9Uc2xicllJOXVNUHJ5?=
 =?utf-8?B?bXNYYWFMQVJKYlE3TEdkU1ZIYkFMYUZKMUdPZzhRcWdkSHdoOW41MUtPbytx?=
 =?utf-8?B?VzV1eWVtRldEK0FZWW8yOGJpcDdVWHJtVFVYdVdnbTZUbU9XaUtnL3cwUUc4?=
 =?utf-8?Q?Rv3RCv6cYo3mYRRkJxuPAY3i2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wJ4DE3UrY+Oxi9vtfLj8wptZysgMDmJedfytOK1ZOYQkbELZZQ6pGI/b4JoVFj6UVhGnkMo9GCCDnX7DiqQ/nm/MCU474z6w46esP2N7aR0PK3gyKj9W7GYVZYfi9oRkXE83He+IbE1mLsjzEljiSuPBxXEPSOlYeqoifq7M9dOsnUlsnEoz0I3lgJj6hyRQVM0uFjOaVtAs1VjyCZiNIy+H0YFNRDKg1doMH6ls9xf7WIVXJyr1NHkvmWCuh6nZuwZSRTjIoS31n8oheYhztbvF5kgt/C46yZOTHbfmyn1qacMVWQOEMRDAv4KkxbC6GiyCc8is/IEghIoMAQ1SQvDuo1qDLkDKdlo0t7dFWwoxsGU2iloA0OkFEVWFTBuRcd2AieAhKwhhHQb63KxOYcclUaeU+pJFlWs9uB2oepl98bd1y7dw90micKVgrOyt5/da8FCbsdpfZzRPcYhjRCX4wDtQtYoUtJXdZaP7vEWFICoc9cw7ndwnjOCqb8lNU6c6Lm5r+nZye5ZfelYXeX2Vcd/324M93MyFqPrjvGtA369JsREFVGExYJu+CeAxZ30vt0m8U3y0A0zS9C9DbNpgAWuMR8Axu5cE1W+11gj6Wy9untlDSyR3y5qOvNd9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b92335-f0a3-4436-dd03-08dc592cc4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:06:39.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIu/snS6r6pPyapgXvly6dFf0UOmHSbNg0jCNusj6ZOF7b/ppcekeZdmBhBWKfHTLrH2JlV/izlwRT9ytq/I+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7222

PiBPbiA0LzYvMjQgMTE6MDQgUE0sIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFVGUyBzcGVjIHZl
cnNpb24gMi4xIHdhcyBwdWJsaXNoZWQgbW9yZSB0aGFuIDEwIHllYXJzIGFnby4gSXQgaXMNCj4g
PiB2YW5pc2hpbmdseSB1bmxpa2VseSB0aGF0IGV2ZW4gdGhlcmUgYXJlIG91dCB0aGVyZSBwbGF0
Zm9ybXMgdGhhdCB1c2VzDQo+ID4gZWFybGllciBob3N0IGNvbnRyb2xsZXJzLCBsZXQgYWxvbmUg
dGhhdCB0aG9zZSBhbmNpZW50IHBsYXRmb3JtcyB3aWxsDQo+ID4gZXZlciBydW4gYSBWNi4xMCBr
ZXJuZWwuICBUbyBiZSBleHRyYSBjYXV0aW91cywgbGVhdmUgb3V0IHN1cHBvcnQgZm9yDQo+ID4g
VUZTSENJMi4wIGFzIHdlbGwsIGFuZCBqdXN0IHJlbW92ZSBzdXBwb3J0IG9mIGhvc3QgY29udHJv
bGxlcnMgcHJpb3INCj4gPiB0byBVRlMyLjAuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHJlbW92ZXMg
c29tZSBsZWdhY3kgdHVuaW5nIGNhbGxzIHRoYXQgbm8gbG9uZ2VyIGFwcGx5Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gQWNr
ZWQtYnk6IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2
ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jICAgfCAxNTggKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gICBkcml2ZXJzL3Vmcy9ob3N0L3Vmcy1xY29tLmMgfCAgIDMgKy0NCj4g
PiAgIGluY2x1ZGUvdWZzL3Vmc2hjZC5oICAgICAgICB8ICAgMiAtDQo+ID4gICBpbmNsdWRlL3Vm
cy91ZnNoY2kuaCAgICAgICAgfCAgMTMgKy0tDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDE2MSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiA+IGlu
ZGV4IDYyYzg1NzVmMmM2Ny4uYzcyZWY4N2VhODY3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
dWZzL2NvcmUvdWZzaGNkLmMNCj4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+
ID4gQEAgLTc0OCw4ICs3NDgsNiBAQCBzdGF0aWMgaW50IHVmc2hjZF93YWl0X2Zvcl9yZWdpc3Rl
cihzdHJ1Y3QgdWZzX2hiYQ0KPiAqaGJhLCB1MzIgcmVnLCB1MzIgbWFzaywNCj4gPiAgICAqLw0K
PiA+ICAgc3RhdGljIGlubGluZSB1MzIgdWZzaGNkX2dldF9pbnRyX21hc2soc3RydWN0IHVmc19o
YmEgKmhiYSkNCj4gPiAgIHsNCj4gPiAtICAgICBpZiAoaGJhLT51ZnNfdmVyc2lvbiA9PSB1ZnNo
Y2lfdmVyc2lvbigxLCAwKSkNCj4gPiAtICAgICAgICAgICAgIHJldHVybiBJTlRFUlJVUFRfTUFT
S19BTExfVkVSXzEwOw0KPiA+ICAgICAgIGlmIChoYmEtPnVmc192ZXJzaW9uIDw9IHVmc2hjaV92
ZXJzaW9uKDIsIDApKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIElOVEVSUlVQVF9NQVNLX0FM
TF9WRVJfMTE7DQo+IA0KPiBJcyB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gaW4gc3luYyB3aXRoIHRo
ZSBwYXRjaCBpdHNlbGY/IFRoZSBwYXRjaCBkZXNjcmlwdGlvbiBzYXlzDQo+IHRoYXQgc3VwcG9y
dCBmb3IgVUZTSENJIDIuMCBpcyByZW1vdmVkIHdoaWxlIHRoZSBhYm92ZSBpZi1jb25kaXRpb24g
b25seQ0KPiBldmFsdWF0ZXMgdG8gdHJ1ZSBmb3IgVUZTSENJIDIuMCBhbmQgb2xkZXIgY29udHJv
bGxlcnMuDQpUaGUgY292ZXIgbGV0dGVyIHNheToNCi0gbGVhdmUgVUZTSENJMi4wIG91dCBvZiB0
aGlzIGNoYW5nZSAoQmFydCkuDQoNCkFuZCB0aGUgY29tbWl0IGxvZyBzYXk6DQpUbyBiZSBleHRy
YSBjYXV0aW91cywgbGVhdmUgb3V0IHN1cHBvcnQgZm9yDQpVRlNIQ0kyLjAgYXMgd2VsbCwgYW5k
IGp1c3QgcmVtb3ZlIHN1cHBvcnQgb2YgaG9zdCBjb250cm9sbGVycyBwcmlvcg0KdG8gVUZTMi4w
Lg0KDQpJc24ndCB0aGF0IGNsZWFyIGVub3VnaD8NCg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+
IFRoYW5rcywNCj4gDQo+IEJhcnQuDQoNCg==

