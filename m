Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FD4802A78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjLDCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:53:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57BD7;
        Sun,  3 Dec 2023 18:53:22 -0800 (PST)
X-UUID: 4553b19c925011eea33bb35ae8d461a2-20231204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EeYKZsWSS5vmLeX3BmXLW3gPJartCbsxBTxfF3BWsbE=;
        b=aj78x+IcL+qJbd9NW4wzbMLq30vq6vUV3k7LygDx8pERBMwqE/3McY56qcaJK0OYdB87xbKmNz1n6/STt59bpzXtE5Mutd7pV9wmwGw3i0A/XB6KjpTYK8hOR978g5hAMRz4pXQVcVNTKSl3AfWNX/5RxQimSXQLovSRRcgHDsw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:00fc37dc-c427-46de-8ac9-770c5908c7ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:3e0f1b96-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4553b19c925011eea33bb35ae8d461a2-20231204
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 995753011; Mon, 04 Dec 2023 10:53:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Dec 2023 10:53:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Dec 2023 10:53:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzYjFGSjn9CpCLO6UorMgccZvqWaNTAkgTlOhVAs+PwU9wdKe7aa01YOM2BF4RpbzLBNF94RtXh24ZEoQVcj6Bu4mjGfPaMr7qVRpTBunYvRoyeP2cRQpn3iJvjNKXyX0Rv7SI6+gm1+vigkBcWp3Bv1kpsSI2qkK6L4o0RPZZsRe9wKWE95J8ODt3Za/J0dq72XvP6TL2iGY/6E7dZ81Eu2LL77G8Ts8u6WWXBNgGCjFqUaIXKyXYWAy7NPp/cuf0fv0rBnyui4uWaDwjZ1c3j1fxurUaKWnIurU5M0Q7oc+9TVa568LEs1tMkqf5GYoi3zoOdJ5GUdDiueuu1Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeYKZsWSS5vmLeX3BmXLW3gPJartCbsxBTxfF3BWsbE=;
 b=blum0ChZ0UpFCJmUpYxtnpe5mPL9zH07j9ktIb3IkNjA6wDk6OuYY1iEaZhifaro10SDZKqYy2oPqQJQ7N/4BLd+et4FxI31IG+UTlqGuJ/Znf1DNaxRCAHIp1xrc4YaW3L5XeMm30RuJjaDY9CYoVtaDrDyBVtPfq4l7kiaa4+gZqxIgVzlBdxnGnjsuPB0R+NjR70UDVEu3+aQ2YRTG8gEUkrHhlqWQrqJF/I3bab4Kubx6qXJHp9fwLTJmu0cSuigDnhfMOnW5PPrTliZ0dKUn7qBJ6i1knGVB50pzIongngHbVHfOMjnvlgWl4hMDpjQuC1Sf+P6KFjFttmNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeYKZsWSS5vmLeX3BmXLW3gPJartCbsxBTxfF3BWsbE=;
 b=GCiaxK2OqPGeOLLOhO5lpo3ZunBpmVSXFECTD9jvuNatn6o706WWJyGQhiXgLhzz7QPnQ8l39y/o2yc5/FNQE4LLeUWsQGkIUNqP1DjJHC7d5bqYe4Nk+baEeF6c358gVJPvw4VtM+13z749gu7rCqWDvbXoV++iIUgXnFhB0Iw=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by OSQPR03MB8387.apcprd03.prod.outlook.com (2603:1096:604:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 02:53:11 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::feda:f2f6:5844:f7d9]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::feda:f2f6:5844:f7d9%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 02:53:10 +0000
From:   =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>
To:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "junwoo80.lee@samsung.com" <junwoo80.lee@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "quic_nitirawa@quicinc.com" <quic_nitirawa@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "chu.stanley@gmail.com" <chu.stanley@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "bmasney@redhat.com" <bmasney@redhat.com>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 01/10] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Thread-Topic: [PATCH v8 01/10] scsi: ufs: host: Rename structure
 ufs_dev_params to ufs_host_params
Thread-Index: AQHaJRxNzz35E4PVmU6KIiJmBJmOubCYb88A
Date:   Mon, 4 Dec 2023 02:53:10 +0000
Message-ID: <25ad8cd317c417031c52beac8b673d953db5e56f.camel@mediatek.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
         <1701520577-31163-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1701520577-31163-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|OSQPR03MB8387:EE_
x-ms-office365-filtering-correlation-id: 7d3bb80f-465d-4702-955c-08dbf47426e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TguC9amnsu7sXZwi5p8i4/HqIlsrn+QmsfgFU/j05I/9+vtSsdaVmT5Uk/zbOM1kmopc2VwtTSRv6igkKrN3+hU/7T3dwl2RsxFIT58I8L1AmMILoBXvwRhheKQSD7L4XVgstceJe9IURtIlV5hMOh8/GrbowSvpzaqynKlhvOBb6dmCPD4jnfV7BpPntNxZjhyptp3Lu1QXw0xzR0oZf+OIqQABnXafnj6PF/1em6KFUIGfE3kPuhZ9pbHyYWEoMe7aD2yyRxgus2uGLAcZZV1Dh7SNFI5MWcmp495h6kGi+A69zZuOaplSqmieq3DesHtw6etDAS/tVNoq5dovc4Y5dGjrAgiZULLjxcdfRV00iNIasS+nzfCdEqzbeIW7u7+C5zzh68+MZqzt8E8nE87jxuqggJM7CQKXiaMabEReLHwLHAcJQ9hH4+PESkNi2v5tk7PhbITJ4QE51Qv+2FFJ42EFQsx47U34SEECvtI3iaH47+qYDjLsEh8XmptxfIBf9Z54Vtn5frxhkFI8bgNhetWAlAmo0vu2CClI2tf3dKr97M7f9gUaafH08218nx33QvR+Zj0Ocu2pA1P3nH4qSW+pQdozvg+p+OkVgnQW/fqJFb4dTqBhQM+2hd58uG5MbhGr2Rep9wwVsDZPXoX4/Sc/jjO9OBv8xiPaT1uvVJvhgOjXRnh/6Se7NdaDW2NwEh1H85ORCHUXpVR/LTEg4u4ozgml5SI6/qBZ6NE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(2616005)(122000001)(8936002)(8676002)(4326008)(6512007)(6506007)(83380400001)(26005)(6486002)(71200400001)(478600001)(91956017)(110136005)(76116006)(66476007)(66446008)(64756008)(54906003)(66946007)(66556008)(316002)(2906002)(41300700001)(36756003)(38100700002)(85182001)(38070700009)(86362001)(7416002)(5660300002)(4744005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFFRZkNLWFplS1EvVC95SzZtSEFTSVRDSzd2YlpKREhBcDNUWjZkQ2pLbkxw?=
 =?utf-8?B?TWRoRmxpcFEwbFBVcEtnTWRFRVloSXgzQ21KcGNGaTVTc3BFOUpwWjVJei93?=
 =?utf-8?B?S1NFU1JJK1dodFlRbFhWMmxYOUNmOTE5Qi9tYmFHRXZJalROdks2OWVHNEk0?=
 =?utf-8?B?NmlLUXplMkNzV25sRytNeFBkYTJJQlBuNW9sK1grbW15NUJ3VTJ3S1JCd1pq?=
 =?utf-8?B?TlFOMVllVWNKOXlXM2REUjNUcTlYMzU3d2Y5MVAxN1Fiamx4Yy9aS3BNK0w1?=
 =?utf-8?B?Z0J5cDVQRng2dlRjYUJXZFVuR1ZITFlhZEl3bDJJQXZJdmdyNEZYSWtlaXJ1?=
 =?utf-8?B?K2EreDdDZ0lUV2hwRHhyNGo5MldXdUxxbGk4d3BIaFVPVHNHSjJsMldNemd6?=
 =?utf-8?B?dVhOZlk5YzFvMnV0NGI2RmYxVkNTSXJrL1lwWm43Qjl0aThXQmdvNE9MbW02?=
 =?utf-8?B?SjNRY24vMTR6eTk4UlppV0lKaGJzTUVYa3J0RFVZQmk1Y0Z3S1oyTGs2d0da?=
 =?utf-8?B?YllQVVVBOE0wZDdkSVE4bHp2a0ZFRGl4OUNkdnJMOEpmeGRPVDVUZzNMdloy?=
 =?utf-8?B?S1lOcjRRZTZHWjFobGdCTEhuWElxRHRZQUg4eFd2QUFrTmRDb3NvRG5XM2Nt?=
 =?utf-8?B?MmpLTWE5UzFrMEV4UElFbjBDY0ZBeDVyeTBiYk8zeDB6UzV3VUcxeTUzZE9l?=
 =?utf-8?B?bThsSUdSMWVaRS9DZE41ZnFkWWphUVQ4c0h1bTRzVWlKeVN0c3pNVVY5NmVh?=
 =?utf-8?B?L3Z6Zm8xNDBRd1pqRzI5RnRHcUVkbkh3em5FU3hEd0pONzlwZ1RNRzRkNVZo?=
 =?utf-8?B?Zm9MenFxTm5FZFZabmJneVk5amtmd0NaNGxEQXlITjYrYmlXTUNzM1Q3MjZK?=
 =?utf-8?B?WS9lZjA1am5OMGZJOFp2OGRSL3h6TUxjOVNLaWlRekFYUW1DVDZkZzE4MnZJ?=
 =?utf-8?B?REk2eGNxV1JLY0VqZDljQk85TTdjbkFjYmJqQThjWnBqbnoxVmlKY05PemxZ?=
 =?utf-8?B?UjV3ZWM1Um5FUlJBR0FEcXJmNHBrZC9tUTZrZkJja0VKR2o2UWJKS3NsWld3?=
 =?utf-8?B?NWNvYURxb1dvZTg4Mk5oN08wQTl6c05ZMTNNN09xMEtTaDMzNnJWU1B4QTBC?=
 =?utf-8?B?R3IzQzZSS0xOVXFoSk9GdjZwdWJML3MrTThwdjROcUZlWW5xY2dnbXZpZm45?=
 =?utf-8?B?ZjNMWHEza3hKa2xKNUltNkxRMWFkN20yT1g2L3pTdk1ZUVZHdHU4dHVDSkFW?=
 =?utf-8?B?Yy82S3RhQW81eUkzTFFtVThzTVZFUDlSN2hBK1J4Qkp0MFBhWUVYZTlKZEhO?=
 =?utf-8?B?ZmJTWlVhNlZtVmx6d3hBbWNRZHpDa09NVUhUdkxUdEFrTkhmRUtNR1JmL1hp?=
 =?utf-8?B?a1BUUzVmL2xORjJveVdydHpyUVd6L2JjMWtMTWZvUzRQektnQUs0ei9mUFNk?=
 =?utf-8?B?blRCY01iWTFodWdrYWFzQTd1T2VkZXFKbXdVUTd1cGp3RHNOSy9RZVBMdXkr?=
 =?utf-8?B?VDVkK1RQbTJaUWxLZFRtcitqSmp0ZzZjN0NLdG9uSmR6ODdYeUZSbUlYc1g4?=
 =?utf-8?B?RlAyb2ZOYzRvZjlYS2ZYK1ZUVzhPN3hPQ1dWTWlnUkFZeHQ4c21LeWk0UzV3?=
 =?utf-8?B?NFdQS0pTZFNTQ3dheDRHU2lkN1d6N0EzYmlqcFJKOElXRDJlRGI3Mm5XcWxw?=
 =?utf-8?B?TlZHOWZCaHk5S0J5YVVGK2dDMm1wdkhFRnl3WXlSRDZUaHVPMjVBNVFiM2NB?=
 =?utf-8?B?Wmw4NXlyNmJ0NE1zN3FjR1pudlNhTnFlTUlmbG41VEducjA5SGs1WmNLOFRl?=
 =?utf-8?B?dmt4U2kxbzAwaEhkdkRnckhZakVkSm1HaUsyODdGSm1kSXdLR1o2NndTOUdJ?=
 =?utf-8?B?Kys2amNPbnNZZ2QrWWkxdWgyanM1OThMdk1ZaHhndlFXMUJxUGF1QWlXRis0?=
 =?utf-8?B?K01QNFNYSi80QnM0WGZYeEFPdmtUK0szZXI4QUZLYkxsLzROaEhpdUlsbmZw?=
 =?utf-8?B?VXAyZWdpYkZoU05GNHRiZzNrUHFPa2Y4cHJYeExZYTNpaWhKdjhoalg4Q09P?=
 =?utf-8?B?SjYxa1dkSmE3aXVVb0ZtU1BwSVhxOEUyQ0hsL3dvZGx6Uy9XVi90ODhCeXRJ?=
 =?utf-8?B?MG9Ha3dmZEdxbnZVRkQveEJrU0ZxcDNNSytpYmhkemdocktUMkNjZjN0Yko1?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF070E36BBCF744E97F7258BF9C14D45@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bb80f-465d-4702-955c-08dbf47426e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 02:53:10.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StLxAyzOYvDI3CS8f3mkV+9OsnX2NHSi9HT4kcD9R9irWN5vLYu+55rx24ymUtH7NElSJtFBQUlDlvd8uLjTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8387
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.142400-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsKf5jPUBmqtttAWxuM5sl5aNaxZBRbNWoX664W6jMPiOOJ
        UkEhc8bP8op+dE0jCqZ/ujNnNM8HUDIkzW3ewGUmHov5mQmFcLvlW98KMjGW7myiLZetSf8n5kv
        mj69FXvKEwgORH8p/AExAtD/T72EbdB/CxWTRRu25FeHtsUoHu7eQ74NPzc0wtBBnwTdRSjVcIz
        PsQcwRPOyq/U6tOJIC+68HqACCvKA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.142400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5965BAD31AF8717B23587D49BBC46CF61823F61C3ACF8AC0652B18A530A3F6062000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTEyLTAyIGF0IDA0OjM2IC0wODAwLCBDYW4gR3VvIHdyb3RlOg0KPiAgCSAN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gIFN0cnVjdHVyZSB1ZnNfZGV2X3BhcmFtcyBpcyBhY3R1YWxseSB1c2VkIGluIFVG
UyBob3N0IHZlbmRvciBkcml2ZXJzDQo+IHRvDQo+IGRlY2xhcmUgaG9zdCBzcGVjaWZpYyBwb3dl
ciBtb2RlIHBhcmFtZXRlcnMsIGxpa2UgdWZzXzx2ZW5kb3I+X3BhcmFtcw0KPiBvcg0KPiBob3N0
X2NhcCwgd2hpY2ggbWFrZXMgdGhlIGNvZGUgbm90IHZlcnkgc3RyYWlnaHRmb3J3YXJkIHRvIHJl
YWQuDQo+IFJlbmFtZSB0aGUNCj4gc3RydWN0dXJlIHVmc19kZXZfcGFyYW1zIHRvIHVmc19ob3N0
X3BhcmFtcyBhbmQgdW5pZnkgdGhlDQo+IGRlY2xhcmF0aW9ucyBpbg0KPiBhbGwgdmVuZG9yIGRy
aXZlcnMgdG8gaG9zdF9wYXJhbXMuDQo+IA0KPiBJbiBhZGRpdGlvbiwgcmVuYW1lIHRoZSB0d28g
ZnVuY3Rpb25zIHVmc2hjZF9pbml0X3B3cl9kZXZfcGFyYW0oKSBhbmQNCj4gdWZzaGNkX2dldF9w
d3JfZGV2X3BhcmFtKCkgd2hpY2ggd29yayBiYXNlZCBvbiB0aGUgdWZzX2hvc3RfcGFyYW1zIHRv
DQo+IHVmc2hjZF9pbml0X2hvc3RfcGFyYW1zKCkgYW5kIHVmc2hjZF9uZWdvdGlhdGVfcHdyX3Bh
cmFtcygpDQo+IHJlc3BlY3RpdmVseSB0bw0KPiBhdm9pZCBjb25mdXNpb25zLg0KPiANCj4gVGhp
cyBjaGFuZ2UgZG9lcyBub3QgY2hhbmdlIGFueSBmdW5jdGlvbmFsaXRpZXMgb3IgbG9naWMuDQo+
IA0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgV2FuZyA8cGV0ZXIud2FuZ0BtZWRpYXRlay5jb20+DQoN
Cg==
