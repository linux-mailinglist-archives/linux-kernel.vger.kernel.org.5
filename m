Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD61C7E2E15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKFUUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:20:18 -0500
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08EAD73;
        Mon,  6 Nov 2023 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=694; q=dns/txt; s=iport;
  t=1699302015; x=1700511615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SeZVmp8mjDW9bSEfUhGob1PgxRYa6Effp9jXkEVtgVg=;
  b=ivFnEs9DrsOCRFEESmy4lcmWw0/3b0rQNJk1fkzUdFKfPPUuiF50Oo/Y
   /QsS3hRsHYSh736geYEcCRBZa4yhFql2GfQI0E/5OUEKu/JfMmv29qnOL
   nTSXVz3YvO5hBFCWz95LSR0xaslXbvWUt4oj2PDmi4irWcocPC/ZJiLPk
   E=;
X-CSE-ConnectionGUID: ZmCUaqO2SbO+muci7+pAlA==
X-CSE-MsgGUID: dYam6XavTTeyz5q4naQE+w==
X-IPAS-Result: =?us-ascii?q?A0AnAADhSEllmJxdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoFsBgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BV4JoP?=
 =?us-ascii?q?oJhAoFig1k5gi+JLgcygiKDVI0NCXdHcBsDBwOBABArBwQwGwcGCRQtIwZRB?=
 =?us-ascii?q?C0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2ECoEFBeBEQRqB?=
 =?us-ascii?q?RgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDAhoFAwMEgTYFD?=
 =?us-ascii?q?R4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwPDB8CGx4NJygCN?=
 =?us-ascii?q?UMDEQUSAhgDIANEHUADC209NRQbBQQ7KVkFoR2DDymWXkmuMwqEDKE/F4NuE?=
 =?us-ascii?q?4xzmQwumBAgqAgCBAIEBQIOAQEGgWM6gVtwFYMiUhkPjiAZg1+PeXY7AgcLA?=
 =?us-ascii?q?QEDCYtKAQE?=
IronPort-PHdr: A9a23:6UWPqx9QzSO+9v9uWO3oyV9kXcBvk6//MghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqNgNvOuXxE436hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:FJvDNa/LjCqSBk4Dbb/tDrUDvX6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 zccD2nSa/+OMWGkKdh0bN+z9ENSvZTUzoAxT1E4/npEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4upyyHjEAX9gWUtazpKs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0I3CCkW2qOvJ9EfhMH7xyPQxT1kfOaRNr46bAUkWn
 RAZACoGYhbGjOWszffmDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGviUjTNb9G9YasRmHv/Ee
 8sdYDlHZxXbaBoJMVASYH47tL7y2iejKGcB8zp5o4I70mHWkjx4zoTRPcvHJ8XWQ8xsswWH8
 zeuE2PRW0FGa4P3JSC+2natgPLf2CD2QoQfEJWm+fNwxl6e3GoeDFsRT1TTif24jFOuHslUM
 E085CUjt+4x+VatQ927WAe3yENopTYGUNZWVuY98gzIl+zf4h2SAS4PSTsphMEaWNEedzkB6
 1aQuInSDxsstaCeSC3e7p6QhGbnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obo0LUZ/hmtk
 1i3QDgCa6Y71pFUiv3qlbzTq3f9+ciTF19dChD/Bzr9tmtEiJiZi5tEAGU3AN5aJ4qfC1KGp
 nVBxo6V7fsFCteGkynlrAQx8FOBua/t3N702AMH83wdG9KFpyfLkWd4u2EWGauRGpxYEQIFm
 WeK0e+r2LddPWGxcYh8aJ+rBsIhwMDITIq0B6qFM4YSOsgsLGdrGR2Cg2bOhwgBd2ByyckC1
 WuzLa5A8F5DU/08lWrqLwvj+eVzn35WKZzvqWDTlkT7juX2iI+9QrYeO1zGdfEi8K6Bu23oH
 yV3aaO3J+FkeLSmOEH/qNdLRXhTdChTLc6t8aR/KLXcSjeK7Ul8UZc9N5t7Jdw890mU/8+Vl
 kyAtrhwkwGg3SSXeFrVMBiOqtrHBP5CkJ7yBgR1VX6A0Hk4aoHp56AaH6bbt5F+nAC/5ZaYl
 8U4Rvg=
IronPort-HdrOrdr: A9a23:qyKOMa9EHTRNU+bguXpuk+Gddr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBQpTnhAsW9qXO1z+8N3WBjB8bTYOCAghrnEGgC1/qs/9SEIVydygcz79
 YcT0ETMqyWMbE+t7eF3ODaKadg/DDkytHVuQ629R4EJm8aDtAF0+46MHflLqQcfng/OXNNLu
 vn2iMxnUvaRZ14VLXcOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXMIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0I7ErXMBeo98bLBiA1zkAnkbzZdBOW
 VwrjukXq9sfFf9deLGloD1vl9R5xGJSDEZ4J0uZjRkIPkjgflq3MwiFIc/KuZcIMo8g7pXSt
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmQS+sUoJh3fw/vZv1Uso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCbKSG6XWJ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdduXQpc0zjBMWS1NlA8wzLQm+6QTPxo/suqqRRq/n5Xv7mICeDQFchn4+ppOgeGNTSX7
 KpNJdfE5bYXCLT8EZyrnvDsrVpWA4juZcuy6MGsnq107b2FrE=
X-Talos-CUID: 9a23:EYpug2/po3+uMOKcxNyVv3wRMf0sa1qH9333YEqlAmc2C6W8TXbFrQ==
X-Talos-MUID: 9a23:egJK7gnsL7xFsnGOtPqWdnpuBc5tvZSnFnwxnIQU5tDYMyVJFnSC2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:20:14 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6KKEmS018971
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:20:14 GMT
X-CSE-ConnectionGUID: 6pqLmNdEQi6ELchDdn4i7Q==
X-CSE-MsgGUID: pK6SoxczS6y11CtxT9pcww==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7049769"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7IqxMDo+KrngXHxCCCV0ek8k7cBHVULUsH7x1HkzeGN2etFqbUwUIRUfIvUdDlddJpo/PsbkhHfD3mL9cxcqMjYQDD5Yjo245VJKc3iauDV1jR8vAnO6YeWABaYEk079r0UDv5QcU7pcNkoDjQyaEKHZFfSjO+yRWLwKiy5CS3bxgW1479zBFjUvw9hISh54KdrasVkhFnmtvAfjLw1YutOJfSZD2nTl5W3EPdSwQXGnSxv3ri1UEbtNP94p1FCbpwIRxhZtH/jfLVXPDsm6d41hB74V3dp3tEMF51Jk+xL58/VQM3ENKs1N69bWQlWW2yKzslUan43SHQGrPHMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeZVmp8mjDW9bSEfUhGob1PgxRYa6Effp9jXkEVtgVg=;
 b=LbKsikJkQ29MpK5CQWw7PjJtwdMQZhp9wY/xNt9/19dIh5J1ymxRZwew49W/NM8uXnsFtq3Pac4TUrO9KBoMjgQdYFp0+K/U6PLU+0ft2xzpV7yWzR/QaYUoYt51DPzuJsGCTF1ziRZpzoVtcO5wV3kZTKuMKSbIYT+zeVS/hGoyBNKZKcgOzhsV119o/89NY6O6GA9jUBvsrLsaMh29MsIXkxUndMPacp+t/YWJLyr85DnN+5YovEHJV92ZuqDhcc1HB+XEQ94r7F0lnFVaQG0d+teQFynsh10B4myDK0CbRkL5iud3noUNPE1hIW8prtAoj0KR77GZei4uwCJEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeZVmp8mjDW9bSEfUhGob1PgxRYa6Effp9jXkEVtgVg=;
 b=eoUzrpKTLfse+y02WwCSO/EOLce74OgbN2IDR0SfsS2rGYvfkPHOLsKGbCy6kmJWzrCXUc+dnAi+/5Ull73FGhM5UzJ18Qs08fHjxJnxt/ozcqQ+F/ZCuGy6M7V52IBIERL16SgGntRjr6mZBmHZU1ioXxOE2UHoMdSAo9mwjec=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 20:20:13 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:20:13 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/13] scsi: fnic: Remove usage of host_lock
Thread-Topic: [PATCH v2 09/13] scsi: fnic: Remove usage of host_lock
Thread-Index: AQHaCP/vpQIqQ+TR1U+uoBHDsLBEcbBmsSkAgAcYaHA=
Date:   Mon, 6 Nov 2023 20:20:13 +0000
Message-ID: <SJ0PR11MB5896A1704B21A1A2C524DBF3C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-10-kartilak@cisco.com>
 <325bba3b-01eb-438e-bd14-9f3d12372931@suse.de>
In-Reply-To: <325bba3b-01eb-438e-bd14-9f3d12372931@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DM3PR11MB8684:EE_
x-ms-office365-filtering-correlation-id: 39d266c4-c9de-4e97-6ace-08dbdf05c844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t0Rwl54MSEh3fMx1l/FmDAM9zViE1HpkaWmQhI3QjoRLwL38LSZLpZtxnczaqterRM1MZE29IIA20AwhH/87KM0II3RzIyMA+SSfXVgZKFgk7rkGhtsmMQdsbHlpqAGBFZjVAtkNFMPwtAChcNBRzlLUAUaqlyFAW6vyWEqpcc+I7qPtKb9HZMqnCUnpcvUQOYIwRhnAyyArPNcSsZzk3rulZuOf0Ss0I0/M0BP8qwUA6tEYIiQzEzY9wiQ0Dr+Wo91aHy2ge4kzAYcTZ0AwgMup31lxzBJom72kZEjRg2FGr4M5QghsHkD7PqBs8e7OfSzhpIT0KEYJ3ljTbpX1pv76o2ddjOgP24AnKW9eA8T7PbxXQ8sPirmPuLZY2ikudSboG21pOmtNJc8pcj/BosB/4x2TjOeb8bN0M1S08Do1ZHvq2F5plJ4gXdRX3qrgL7Ulq6R29aDu2PyvfGQK+uFOAgxTrNyR8TRSMYuNssa9A/EdjUvuHeK0VKV6fNJ25fY8sAmvtZHnSyKXB3c9Q9Yi28twvYHTk5b//7gYa/aXpVRaGqtkSC9xin+AnsOx2fv/08vZB/yoH1c5t9pZf0P4ZUYBGbHLhKRfpzEhYhraFfRJ6T3opcYlte/T4We
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700009)(122000001)(110136005)(66946007)(83380400001)(76116006)(478600001)(6506007)(7696005)(71200400001)(66556008)(53546011)(9686003)(2906002)(8936002)(4326008)(8676002)(41300700001)(55016003)(38100700002)(5660300002)(4744005)(52536014)(86362001)(54906003)(66476007)(66446008)(316002)(6636002)(64756008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEp2aWVNVjAxMmFCeTRyMVFYU0F5MEhCNG91b29zRnlub2hvRVQ1Tmg5Wks2?=
 =?utf-8?B?ckFJVEw0RVZDVTJRTjJoRXFWSU5XNXNFdGl6bTJISEdCSGJZM3VORUpHR0tD?=
 =?utf-8?B?M0F2R01samQ1SE81Skw3aTBEMTJMaFdENHlneEgrMXEwUmRTQTRaNjhseGlW?=
 =?utf-8?B?U0h2bHBjT2dEU25HVURuQXJwcG9iRXM3U3o3dE9lZWIvaGhnWFNWSFJpSm9p?=
 =?utf-8?B?L3JnOS9CUTN6WlE2WGg4M2RLTDZBNmZvZ3FrZ0R4VEQxVDdNL2Q0aCtERDV0?=
 =?utf-8?B?RGoxNXFXbkNWVUFWY1cxNjVrSmZaYWVhcjl6VkhtVlNFNnpvbmJEdmRVWW11?=
 =?utf-8?B?dnRnV21mOUdLYjlBcTd2WmFGV0cwS0p0UWxMREZjbFprV0E2VXdNc2p3SUZ1?=
 =?utf-8?B?YzZ3UmVHODVEL09zUVhMK2dkMGpWdloyd2VqdTlHVzJoRFF6enhEWnFSMkow?=
 =?utf-8?B?V3ZXbWZEWWRMYWtPZ1ZPNWxZdkp4K3BhaFV1MUUxcEdlQWY3SzVrR0N3d2pF?=
 =?utf-8?B?VkJnNi9wb0doUTlyWmJkTGhFd0ZiY3ZqNGZic1pEZ1RubEpvSEUxOENvWXhv?=
 =?utf-8?B?emhlNk9HU3JKWm0vYzE4cUpwQmxYa1Vvemwycnd2Q1ptNVZydDZwZm9YV1lx?=
 =?utf-8?B?Z1Q3TGJFRUFVRGFhVnFkN2lpenNIaERIS0g5WmpHaHlnTURPWHRnTEk0VFRI?=
 =?utf-8?B?VGh5cWlBUXZ6NWpDYXkrZVdLa1dDT2NmZ0FlSlFyOHlsNnhFT1k5VWdiN3FX?=
 =?utf-8?B?WmlaTlpTV3ZZT0NmSkNpT08rRkJuOUZKVmVEeHRoVzZkbSttN2ZxSjJGSUJU?=
 =?utf-8?B?YkxwekZPWXovUlFmUms5and6SzdBV3lTVEQ0RS9KbjR6RDdmb3dhTXR2TjB0?=
 =?utf-8?B?ZEFGalNjMitOZFZZazVMTURmS3FDMXpPMnMvNUVtQU1BZFljS0pIbTlOaDhh?=
 =?utf-8?B?WkdyR05vVXA3YU1jMGhRVmtRT0FScDBrOUJnNGx6cDNKZjdkUGU5VDl5MWpm?=
 =?utf-8?B?YUZwc3NDSTNGM29JekpOMDMzTjhoZTAzbkZ6U2VjWGlmTnpvclFMckFmc2pD?=
 =?utf-8?B?VkNVTkJLL3JlM29FbWxNc0lkODQxQlpCV1FaYVBJMFdtNTc5VVIyUVA2c1dj?=
 =?utf-8?B?dWlTWndLVkwyY3RmK0lMS1BwWEU4bE1mRTViUDlDOXhlNFVJVTJ3Skw3Tndh?=
 =?utf-8?B?NU9rYlkvMzdBdFFEYnF4aEh0MzNxai9SMWZzcHdwZWZScU4ydG5SME5HQnBy?=
 =?utf-8?B?UlRVcThjQ2J4eW1JdWZHYi9mZjVCYVMyVUloZjQ3WEZzK3hMa09QMURkYjRj?=
 =?utf-8?B?V29nMVlxQmhrVGRLZHpLcEp1MzlaaUNlSnJRN1U1bEw1OXJXZVNGa01JYk52?=
 =?utf-8?B?SDNYc2V3QkVZSG9MMHN5OEhxR3Rna0E0cHhFeUJDWTFPc2RCaGY4R1JCN3l4?=
 =?utf-8?B?a2xOVFJuMFU2UkNGTys2Q25ZbDdIbFNxM3FZL3EyeUF2eFd3ZGxWMllUUmlq?=
 =?utf-8?B?K2RzRnlwdWhpTU5MTGxybTN0Tk5NcU1EOGVNZXgzK25JMDVldG5ieWVGbzht?=
 =?utf-8?B?YmFoRHRKdVFoRk80R1J5WmliWis4dDJHbE9mR0tDVUwxdHpnWFVYeFZKKzBO?=
 =?utf-8?B?N1ZvRExCdjlRVHpveWlFL3JrMzZRRXV2VEpmalc3NFBlQW9NanhlWHBRbHNr?=
 =?utf-8?B?K1ZCYW5Td2N3WjF5T0tlaFoxQk9qK3BLT1RBK3JUTmtEdHZvSFllUlVka2xy?=
 =?utf-8?B?OWF4RXR6dkZBZHpuQkUwNHlCS3RFZjBDNXFYeGtzalUzNUo5NWF2Z0xXUWNM?=
 =?utf-8?B?dHRCQU8wQ3pBVGZQRVZhUzY3REN4ejE1bU04TlB1SWFDb2R6M1dLZXNyalIw?=
 =?utf-8?B?YndQZHpRS292UDFtWE12OWFZVW9kU2RITDdrTW9SeE13OXhuWWxGVHhzQ3pk?=
 =?utf-8?B?K1dDcW5Ia3Q4NHdHakFPaG1DMFZrVlZoOGduU1M4ZllGRGc2N3hINCtrUDdm?=
 =?utf-8?B?K0RGaFdkalhTTm5EQzVtaFpwVDdlejhsaksrR0tiaE9aR1pxS3ZSdWErU0FH?=
 =?utf-8?B?clJnaXBwRlZuVC9PRzRzaTVzVVZwKysvclBOMkRURGxPaE9rTUFtcENxZWgx?=
 =?utf-8?B?NXB0MzFXTEFQTWlSQzczdFdDT3d1UjRGdFp2dC9SbnlzMDMwOFY4eWVPZW0w?=
 =?utf-8?Q?uxgf195GXcV68vbwOjmb4ZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d266c4-c9de-4e97-6ace-08dbdf05c844
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:20:13.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoUmf4yZ5mniNHVvx6ph3T+Mu+9yRFHHyEKiHQ1ktRPDkKDIiJ+UvpJjnWqxxcCoUHl1AMVI8X3nQuwwzly6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6NTMgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4gSWYgeW91IHJlbW92ZSB0aGUgbmVlZCBmb3IgdGhlIGhv
c3RfbG9jayBkdXJpbmcgcXVldWVjb21tYW5kKCkgaW4geW91ciBkcml2ZXIgcGxlYXNlIHJlbmFt
ZSAnZm5pY19xdWV1ZWNvbW1hbmRfbGNrKCknIHRvICdmbmljX3F1ZXVlY29tbWFuZCgpJw0KPiBh
bmQgcmVtb3ZlIHRoZSBsaW5lDQo+DQo+ICBERUZfU0NTSV9RQ01EKGZuaWNfcXVldWVjb21tYW5k
KQ0KDQpUaGlzIGNoYW5nZSBoYXMgYmVlbiBtYWRlIGluIHBhdGNoIDEyLzEzLiANCkluIHYzLCBJ
J3ZlIG1lcmdlZCBwYXRjaCA5KHNjc2k6IGZuaWM6IFJlbW92ZSB1c2FnZSBvZiBob3N0X2xvY2sp
IHdpdGggcGF0Y2ggMTEgKHNjc2k6IGZuaWM6IFVzZSBmbmljX2xvY2sgdG8gcHJvdGVjdCBmbmlj
IHN0cnVjdHVyZXMgaW4gcXVldWVjb21tYW5kKS4NCg0KUmVnYXJkcywNCkthcmFuDQo=
