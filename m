Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721627FD6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjK2M2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjK2M2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:28:01 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC6D7E;
        Wed, 29 Nov 2023 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701260887; x=1732796887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dR/jClvt1j/6X8JTICMCmApCMlkZDovEONtnB31Z4ZU=;
  b=mIMkqppcDY8vRqkZUQxvsBpLZVHgKj/urbu7skVpjYS17TXtfpTvbwYJ
   MXgzz8Tva6RypkiF+wQ5G4yzaY/8tF5uo5oB5lZQpx1SQTP5pRbiqZtrl
   ell55MCGidHsYoX7b8tlaVl+NwszuQ7Lek7/JHhQYXpMY5v2MLgr5llOU
   lKFmtF+udprakMYp/zP3ixj19hdezTrpAbwVLXdVyT3FB/C/Ee8Ob64RZ
   +9rwYWXL1vl81d0eI83t4JYpF9H7JL71Dcy9fYiDydorwqv+3hMbY4vwJ
   j4MAFMeUWwYMVg6klAcNaJxL5GIrQtpPuauLEvKURr4xlRqFuRZsUdMYu
   Q==;
X-CSE-ConnectionGUID: d5zJgRM7THqm/3mjVjqh6g==
X-CSE-MsgGUID: jCcu8vShQ7W9JNZzauc9mw==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3711136"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 20:28:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfLyoTmFXb9t6KSVuURcNOubRUEyRWbesTVml2+kW0FsZC/4rsrOkTBlhYAiV1uDxC+MDNdNsT147f11Tu8fGYjANWZ/1kCTbKZjBSqkG8zcECkKHhqhQZS04bc7Sj5wocwtrOy4+LkF7B2m+pGgaB6uyZbRMIgnDCHhXJTZ+67xwcD6gjXKxAC3vZ7Z4n1f4fIh38PaooQ2md7AAT0mpntu+R/oTtLsFlK4uASaiRL5cNLdxs50YT26lSR516mtnUZPpL6bHvckAXC+pKhUvxlfL/6R2aB0p4ytjCwWI+/Vu76EVf17r2M149qv02KYncA0CRJkRMGZaEBAaZIEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR/jClvt1j/6X8JTICMCmApCMlkZDovEONtnB31Z4ZU=;
 b=as6Kgf1FyHJSBxaShS6f4gSfxg0bF4Zq+9AD3wrAN9k/nSKDZzIghfjEmfBSdmZX+MukiPPHR5LpBPccZ7RBU2bX3gd9eUd98cOoZ3WCnnOqrotpgn+qHO6TxcB34KVlW0mOPKAlkzN510kDs0heCSc5gY9yQSR97E/wiNJzKChDXAdWTVbgXomxZ1vftUkcZyytJ9MiZzRmPAawzj8Dkoixqw4OWfr6e1zfAdKObUpdkmvIvqVyY3bA1nh6rs1Nav/krZE4gLpxMzzShZxY4J8+7rZhkLK+NmShA/Tf12+zZ/oShCz7/CGwCePjCvFZFUA7sD1iZh28oXy/ag59iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR/jClvt1j/6X8JTICMCmApCMlkZDovEONtnB31Z4ZU=;
 b=HmwBMWEJ+SmFBr+5Ah7610CPFVmNKwnoDPlgQ6op9g97VkjxcqF8faX0wIG4Ce76u1uktzUAARuwgEf5XisEhnRonpTzquO/VF9RBETmlpI9AHub8YW0tjR+zRkE6q5K/nqyrwLfWtFn5bR6KSXwHP+V2V5EYeGjDuJrQeluLaE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8464.namprd04.prod.outlook.com (2603:10b6:806:32d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 12:28:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 12:28:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        "mpi3mr-linuxdrv.pdl@broadcom.com" <mpi3mr-linuxdrv.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
Thread-Topic: [PATCH] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
Thread-Index: AQHaIryKgK6SDVBOAUanVvUB12p/pbCROYQA
Date:   Wed, 29 Nov 2023 12:28:02 +0000
Message-ID: <28a90d56-6c76-45dd-901d-709e87d06da5@wdc.com>
References: <20231129120626.4118089-1-arnd@kernel.org>
In-Reply-To: <20231129120626.4118089-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8464:EE_
x-ms-office365-filtering-correlation-id: 02ca4b45-950e-4984-f08f-08dbf0d6a1ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F69HZWEjB2102T/ak+VQ6Tak2vsUbZ7JbeKTKStc8FymRlNxAji2iEkJ6W04WTpHD4TpKW35LdT1J3ot2wijJs72El19ar6KSh6LLGW8vMvy6SD3ebFcVgUD0DX4Wt0E3AiDHht8FJ1p6nB1JqqIncSVtJrxR88bW4KE6jZCZbliwwOwC8RVdYmaZ+YFjZ/HSWEuCKYNbemYYic6TAaCdnu6DqsVXtr2BOVtu14sxbA5M+j9EhHDlLOrqNkhsxbwKjoaWNHJkmJ/BSUtWxuMzSdCCPLbS9Yn/x5nY0fxk5alJ0Q9ZzrCPe+9Jm6xWedeLwoHoxxmfuYtUwh37XERXOcdYJLLT/KdDB70aT/ydB3RnUfJ2u1f3IV3HhnLYzSZ2wWJmPcvQMgTxHJJDH7i/11Pl8ZlQwVYnYoAXYtP6OEW66YpCb0RrPCpIU1U2bKb2U4maS2cxQ0JhNqzZY+QZKOaazTX7xxSn0KsB84ShdLgoz16dYuM5JwjX3aPgWX+RCXT2574Ga2Ik476QdWF7Y0Esg6vR7XlW5wOg8Lm0RTw2to9/9/suf9fVV3R4Pz40uTTiIRCT26wmZm2nQc5hHDGFXXwpIkqVDZig9Ktq5lsLn9/eA/Ojd8tp825WLMJnTfwfQyVpL8VP36LEbaRzpgL2ZD/hvd0lmXUNOLQ6SzstDKCtr1MjpXNmDqyWIxhQHiSwIck9RbY1Vdg7Ay03w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(71200400001)(8676002)(4326008)(8936002)(31696002)(6512007)(53546011)(66476007)(91956017)(66446008)(66556008)(76116006)(54906003)(316002)(110136005)(478600001)(6486002)(66946007)(122000001)(2906002)(41300700001)(6506007)(36756003)(38070700009)(31686004)(38100700002)(558084003)(86362001)(26005)(2616005)(82960400001)(7416002)(64756008)(5660300002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNLSVcrczAwb2RCU3VBUWZwOUhYbmszNktQcExnQjBIUVdpLzNNbHBUSDJI?=
 =?utf-8?B?dXlaQXgwTFJ6NXA0a2w4cVlrQ3J6ai9VazdDOC9BcEJnMzkwZ2ZpRTJQRlpQ?=
 =?utf-8?B?d0VHM09URHlRS2JUWEErbUtVYi8rMGpnREhjZElxaWhUZmVPSHJVSkhGV1B4?=
 =?utf-8?B?WlZCQi82Q2k2MTNzUm1YNFRscXo4RjA3S3FQYXEvZU9HblovWGVNbnZ5czBC?=
 =?utf-8?B?ZTl0RzRJWkRHNURVcWV3ZDN1YTNabEhjdVp1RFJjZFN1V3lEYVFIcWw5OWJ6?=
 =?utf-8?B?QlgxMzVmN1BoYzVtSUIzWEdKVU90NStvTlBCemtmTUliMFc3VmZ3b2owSHJR?=
 =?utf-8?B?am9lZUo4bmxSVVAwMkVyaWU4Zm0rckdzSUFFQlJ4TXlNS05mRnlYT2xkWE9X?=
 =?utf-8?B?cVdpY1JLL2JUUWd3Tjlab3RTTmhpNTRBcDVtTnRZVzFPalE0VXlRRkpVUmpu?=
 =?utf-8?B?azQrWXNVVFRQRjIzOHpsVjhUOUhJUWF5ekp3UEFqc2J1OVMyU2I0eTRRck1Y?=
 =?utf-8?B?alZEK3c1bkp6N0FSL01uSU93S1hPUUpSZG0rV1U0a3FPcGZ4Tkx4T3BMV0V5?=
 =?utf-8?B?VWZva2E4NUNmSjQ2Zis2UWtLTCswTWNTM05nRjIxWWRrQ2tiWDdTTkxBbk5j?=
 =?utf-8?B?S29QVWFMRVhPSmdzM2FGRmtLY05CRDh2cHV0SWtWaG1xY3R6dlNsRGJXc0dx?=
 =?utf-8?B?TGViY3BVTTBnMk53R0FRK1pWL21hTUZMTFAvSURQSGRoYlhMSGdhbjMyMlYz?=
 =?utf-8?B?L3hTb2JzMjBZRFI0MGNmUEpDbUtFdnpZbTJpUWdYSU9oVG5VNGN0ZmJNaWdN?=
 =?utf-8?B?Wmlrb3NaNGZ0K0Z2TjZaSVk3RGNSVktNcTlNZGU2RlBFSzdFNTVpZm5lTnhK?=
 =?utf-8?B?ZjBVd0cvNWRxUm5KNFF2RGpRNko0eXFNTE5qWHVZbjNEd1IxTTBkMXJFdk1k?=
 =?utf-8?B?Si93RWNhSGtxSEd0amQ5b0JXUXZBWStnSGg5LzE4MlZBYnlXL0dJdk9JMlZJ?=
 =?utf-8?B?N1BhMnM1MGNHU1U2S01yWlhGbktDdzN1cmJTZWxSRXlTWmxza3dpblgzNjFB?=
 =?utf-8?B?VVVCL2cvZW9XazByRk5EMHRGVXB6UkJvT21aaGhoV2J6NEllUStmZk5QVnBr?=
 =?utf-8?B?b3VGWTNaam0yVGxYZW1vTXBRTjl3S0xQd1BpS1k3dUg2aEVhQjBWaXkvY1RC?=
 =?utf-8?B?b2N6b0tPMXNmYTlVVnlyNUNoMnl5ZkQ3dWEwcTJTaTIrNWFEK28rRzNhSEpS?=
 =?utf-8?B?cjlnOU5qUWJjckJZYmowS0RhNjVIMFFpQ3Z1eEhtVFhIdENndDRDcldaeXh0?=
 =?utf-8?B?TnRKSjlYZ3dLL0hJTDhwYkFlTWJRQXZPVnZqT3d6OVo5ejd6cEViN0Y1bmhh?=
 =?utf-8?B?elpmYTIxaHVPdkgxZkp2bnlJUnNCZ1JlSGNoQ1Zhb1lWSmpiUjZUQWlPNTk0?=
 =?utf-8?B?eGZOS2JnUThWdXBLN1ZNS0ZjRTNrTStKemRjV29ZZUJJMXI0MGZieWVpNGRq?=
 =?utf-8?B?N0tNc1NTTUtqUEJwaHp1cktmTGcrR0RFUC80dUxzeDdnMmM4clNYajVlVWV5?=
 =?utf-8?B?M2tkcmRpQXJSYmJmWGMvOWxGa0VmdWV2bXlyMU9FWjZESDIvVWZ0RGlTMGVW?=
 =?utf-8?B?bHBzMmpwMXVUL3ArRmFiRXpjVHM0emZtZmlWV2dodXE1MXU0UHFhUHZ3ejZo?=
 =?utf-8?B?Q092RS8vSmFtcWRzQUlFdmI1d3lseUhPcEZZb1Z0QUVvclNyb053NzF1M1lQ?=
 =?utf-8?B?ck9KTzhIRjEwV0VRSndxdnFqaHM0TmtsZ3c4enJ2cGR0Z2ZYTjkva3VDNGMv?=
 =?utf-8?B?UWhibkhLUlVkY3Ayb2JuWmZLSkg0QkRkWERrRnRZNjJDUGtCSTFFOXJ4UEJG?=
 =?utf-8?B?eUF1SlFxWnFVL2xVc1Q0WDBwUkNwamh1WVdoSGFVZXd0QnhHdmI1ekVJRGZV?=
 =?utf-8?B?N0VjMVplVVZ3RTBmYmhqS0ZVVXE5QW5kTU9NQzhtMitLVitDUzlBaERVamZu?=
 =?utf-8?B?K1RYWUpiVkxBZktKYUF2YSsraGV5dzFJcTk3aDFhWkpiOHcwYVZOaWdoTHd0?=
 =?utf-8?B?cUlCMlhKOFhTSE1rTllIYmRWMHZvU2hVSDI5amFMQ2h3ZWNGa2FJTnBHSWhm?=
 =?utf-8?B?Mkdid0RDL1hWZ2lsUGp4cjY2RnV5S0hQKzQyRXY1NlEzcG5xMHZiZVo3cVRX?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B30667967AA3D1479D3D61522A0D4B68@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MGtkelgybk9LVllPb2J1UFhLQ3pieDRFaXRXbEFuSks4RUEvZ0dqOVMrVlVD?=
 =?utf-8?B?ZTJ3bS9jZFUxZUc2dXNWSy9PTjJ3WVRsR1BXbjRIM016V09OZkE2SkhFS2lV?=
 =?utf-8?B?VXY4dVpoV3ByM2tRZmRxQ1Z2M2NCRVVIRFFrL0lkU2RSa3haTnZJcCtmS3Fh?=
 =?utf-8?B?RFp5ZHFMdFJJbk5pbURudE16dGpVV2cyV3YzaS9xclJPTnZMdmduTDF1M25q?=
 =?utf-8?B?OTBkMjRiSTRxdmswa0QrSTB1SGRxZWIxb1hySnMySHVrenJ1Y045QzJlRVFa?=
 =?utf-8?B?bCtLTE8zdjlRRXlpYVJmTVczOWFKdERYZHZBZVJQY0JSbkpuMnBOYUl0KzZR?=
 =?utf-8?B?RnYrZURYenV5dVRzYzd5OWg0anpCZHhnVFlSZkpSZ3pVVlo0ckROMWl3Yzl5?=
 =?utf-8?B?L1AySkxHWGRxcmVOeTJhQSsyTmxpUkJEQ0Fwbm9ub2toMzB0YXkwN3RLL0FX?=
 =?utf-8?B?QUZQdHRNeXVvL3lKN1poMURNb2RCa1F4Zy9DU3I4WTFZaDZUTjFyWHBVU1BU?=
 =?utf-8?B?K01QQnY3dzd5eEs0eFZ0cHNQVnhkaHVZczNpb0dqQ25tejVESWtYL2J4WU5O?=
 =?utf-8?B?Z0RPcTk1NnNFalAvaGhGNVJ1azhTazBhamxIK3ZqbnRTcFFQZVZGZmQ5K3VO?=
 =?utf-8?B?ZmVPU2hjYXpxVUFRWDhZOTBIOEpja3FXdlFDeXhKOURrZ3JVdENJSitheEhW?=
 =?utf-8?B?bnpVL1ZZWUQ0a0c3SVIwRGx4LzN4bmlTUjUwd2o2ek40aVZ5V2t2bHpQNytu?=
 =?utf-8?B?WnlyWXRndzRyQVdDaGFCUHh6S25wSjQ5WW1GV1d1K1lWaDlhZmRTL3pEZXlm?=
 =?utf-8?B?N2xLazVwaVJja2V4dU9BSURLT0lPUi8wYnVzd3JqUUVWSTl1RTJ3c3lJb2tu?=
 =?utf-8?B?SGJIZld2dTIrR1pSYmV1MWcvN1dEL2VxbmZqRCtKdTF4Q25Ld2Yyb1JJQnJ5?=
 =?utf-8?B?N0hqQnlBcU8zL2ZLaklTbmlCUDRLOU53M1F5NFN4dWZJWEorQ3R5SGwweE5r?=
 =?utf-8?B?NEFiUTliYnE5bXlhUFl6bHQ5blVmMGpOUUl6aFNialZzSWg1VjVnZEhSOHJq?=
 =?utf-8?B?eDZaZ1QwblpwcGxaSW5OUExpTGEwbnA1aDd5WFBQZkZRcTgzS1JUYkxqRXRl?=
 =?utf-8?B?bWRnTXJ4WnlXNHIzZmJZazVnRVdBam42T3VPcUdQb1hQdGhQU3hPL2d6eXYv?=
 =?utf-8?B?dnB5QXVERVpTT0NVajcvdVZ2RkRWaTZ6NjVUdXg1aE9WdnVWNUlocFRPblRt?=
 =?utf-8?B?blZBTWVPcWwxVEp2RnpFMXczc2lyT3RzQVZFSUtYY01pUFg0Zz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca4b45-950e-4984-f08f-08dbf0d6a1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 12:28:03.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0D/MB6sEJBgge6z48ACEq2sByQ8z02HRIV0CdzfNvt3VafVd1lnUQ0FkjzhRcOnuPyTlzPEP99cy19fU1WYQBY8ZKC4ikoVfXClQHyWjLCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMTEuMjMgMTM6MDYsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBUb3VibGluZyB0aGUgbnVtYmVyIG9mIFBIWXMg
YWxzbyBkb3VibGVkIHRoZSBzdGFjayB1c2FnZSBvZiB0aGlzIGZ1bmN0aW9uLA0KICAgXn4gRG91
Ymxpbmc/DQoNCk90aGVyd2lzZSBsb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
