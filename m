Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D716B7EDC39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbjKPHqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjKPHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:46:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE83A9;
        Wed, 15 Nov 2023 23:46:38 -0800 (PST)
X-UUID: 42e59920845411eea33bb35ae8d461a2-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HtMBzTuUgWKz410DcDezXSLnzlGXCxWgIBJV2Tkqmb4=;
        b=WGOvOJ4xgcX+t3YCv3du1+LnCIfBdWOyb83E+dVgsyh49yJ5ZTHpEM/lqVw71NS+ZwK0XFZlfdwn0xIiY8mQlwUSVRTthtmMhP+W9/5+0mtwa0wSs0+gRrtBN98aO+VLzJ6QTcpjXGDRs+oVRcWQBhQtX6UtRGnW1O0UaxzCKsA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:322e1dc6-b132-4a9b-b59d-be4cd86fbda2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:d00b99fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 42e59920845411eea33bb35ae8d461a2-20231116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1207438643; Thu, 16 Nov 2023 15:46:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 15:46:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 15:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boau7vzsLu8+MznTOxxk4OLjwEgRKppKO/T/uJ4t8V/26+FzFNn8XpgIgAgzp0pifwY1KPW92yBFBQcmHnJMhjjP/Q9YUJR09+FracdQ6m/xdVOuay4mwJAuKtnY32uBjzY12G/M9YbWpEnPruK7hD8TNak3qcXbwPWmcnD9N9ldbrjX6DqqQ3NDGysiKS/E9NVjyJQ71iIiS9efnAmMwrjlmvQ880saoL79Y2Bk882RpdN4wa9l6iCr98bHGTCfltvp3JkuTp9AVfcWUKoEE+HGiqpVMa4nGJuDPdRcZUZmRWmxzaZHms60+6zsIVjRcetbXwdTQw1HZveta/SA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtMBzTuUgWKz410DcDezXSLnzlGXCxWgIBJV2Tkqmb4=;
 b=n+ZxEDxDxW9WK+qAOkeSFuMMcyLQmpemcDJCadaJgMi4MfTXBq7mPfaRcbfd1o0T+YSi9I5D83W2oo0GXKjDSp0X/zAUZ3h9Ou4pHHobOmpnWSYYJIyfMg9FY+dbOiaXVnDfLoZFG5fgS0NXnzchPR2VJvfTjeYrmTLrmIr0Wly6Y6Ocq1JbJni+zmwHO87xT2yH3W/t1w9TyJnEXWLYYOcyE3DWPgEuDhjI4BcjPNOhHLiuqLlAmq7BEPMzCpNNcsoVABVIz30k/Xqhm9hxYoz/7XAcY3CfrV+HNKPc3+Y+cmQNQNnlskJmAVwri6N6fno6OY/skUOUB5abSAlpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtMBzTuUgWKz410DcDezXSLnzlGXCxWgIBJV2Tkqmb4=;
 b=iCvXVsfxhIhQObLWvq9mknrK7A+SBqW9P32fV0PZzsWBNbAu0btAoBuCcN+oRbHDbr2BjN2rCJgYcKVKd7cD8J5vpKUubCw9WXaX7eeOU8MRUHeEmQ38HkoRzF9xe5Q1cln2wMWad4ujEB7Img9opMdYs1uZDMLBaCQrZACpme4=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by SEYPR03MB7339.apcprd03.prod.outlook.com (2603:1096:101:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 07:46:28 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::744d:5eb2:b571:9c45]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::744d:5eb2:b571:9c45%7]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 07:46:28 +0000
From:   =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "chu.stanley@gmail.com" <chu.stanley@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] scsi: ufs: mediatek: Change the maintainer for
 MediaTek UFS hooks
Thread-Topic: [PATCH v2] scsi: ufs: mediatek: Change the maintainer for
 MediaTek UFS hooks
Thread-Index: AQHaGDlGc00d+1rhXkKkha35V6A5lbB8kY+A
Date:   Thu, 16 Nov 2023 07:46:28 +0000
Message-ID: <2c4b9bb6df34b26b1e7230944596b7da8dee66de.camel@mediatek.com>
References: <20231116030123.10820-1-chu.stanley@gmail.com>
In-Reply-To: <20231116030123.10820-1-chu.stanley@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|SEYPR03MB7339:EE_
x-ms-office365-filtering-correlation-id: e7f65430-0c9d-4fb6-d041-08dbe678245d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OEoPjqT/NGx4nXi8498gswujpuVRiaCInS+loSRJS2Z0VInFwzaBmzOZo29cMTurmRxi0R4oTHSsiDxPt9jDiqD4kq3oG4WV/V6+ZyOSm9zQYsk/06JKUsfyjL4xldybNjkFkRSnr6xO8ZbgShqaXLCEfrBVAg4gLKYJIGM6ngWc6aYX8/U8dc61/KAq+XgLpdfYx/tfnd69Cz2icRKEK/1ZJvQdzAvEPP0uXDJssUCHM3PMF38m3CSDEZuopfx4nLatP29NSu/n03lQ+w/XqhYy9062n56T9xEpBqazHFkUBTUieraVDDfsJELuHlD/gBHIxqA021JbHmEzLbhqRtIjNOF+9mQLTVh7bTbRQSX/g7B6jC0Zj+VCiCwHYlEoUFHknaYpN3an5h6vhTgguxj5HYuQAUysizNtPTtqdMCJNvRp6t4eCwMcc1Zgkhrn/sojdqBvjmEZsV5Y+3miI11jqHrxvcAC+okglOw6m8wLoXZRSXDaJcyqON8WWmF81jIL4vmOXoSta9ig12vUJiyXRSZf1rphJpg4X4G/TDn0q2UbrlFJLO0kLF6VdmPP1uXsNwJdWqUK1fVcnP46SUgU6OKIQcBrzf0k9jFksJepg865JeMhkTXWJzG2KIAhlCxxG9cd3DipBOiN76U4Bs5d1FpIvGy6XoUTquazT6/+Ok5suNsjqplj/E/4y9hcqtScKSRj4s+hTs69QV+1zcj81tULGxiSoWci8x9x3VX6O/cqbJ3FcZ3JNAE7BhN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(122000001)(38100700002)(71200400001)(6506007)(26005)(6512007)(7416002)(2906002)(5660300002)(4001150100001)(41300700001)(921008)(8936002)(85182001)(36756003)(4326008)(86362001)(91956017)(66476007)(66446008)(64756008)(54906003)(38070700009)(66556008)(110136005)(8676002)(76116006)(316002)(66946007)(2616005)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFFpTFY0ZnB3S3REZDYyRXZ6cFdCOTJTUzBKRkx5Mm9KUXA0S0trQmRPSlIv?=
 =?utf-8?B?ZHRraFF3bTA0ckk2cHI2OGt2NjV1NFN4Vjd6TjNvOTdOL2JFbllzRUtXVnRU?=
 =?utf-8?B?OFlMMEFyMXZ6WXFJSmJCU1c2NG42bjE3aGJDRmlSM2JPWGFqeWdjUHdwVzc5?=
 =?utf-8?B?cUNNZ1VlblF3U1R6ZjErZkdIbUI0bHFmRGd4UDR4VjhHYWZTMktmUVVLWmVv?=
 =?utf-8?B?WS9uWDVhNnZDSTRHOUpFdlkzdWdVR3VFTXRwQjg1bzVMck1RVUNvMm8xbUZH?=
 =?utf-8?B?VWJhdnUvbVQ2bUI0VUtSNHVTMENTbzEvbGY0M3hlSmNDSUxZa25FancxUVZs?=
 =?utf-8?B?NWlsdDBWRGdOZ2o2YWNNY1dVUTY5M2xaZDJNOHM0U3duTjMvOHczenVzQmhv?=
 =?utf-8?B?V1VTdjMyamlqemI2OFpzQ1dZSmh6ekdUMVpXcVNsZzQxWS9ocSsrR3JoV1hQ?=
 =?utf-8?B?UkR5d3VPbXR1NitqWE1oV1F1eWFaOTN3dWYycEdkVkc2cGMyK0pqaXN5WFBI?=
 =?utf-8?B?Mk4yUGswak52aXl0alZZcFVKOVdXS1BlLzFWM001bEw4WDRlYk1WS1g5SFdm?=
 =?utf-8?B?cHJ2bDZMb1gyTVhKNUNRbThSYk05Y3lJNXlGY2hGWElGUGlNYlQzNzZuRDJV?=
 =?utf-8?B?U0hxdzFuQlZNcDc3NERWY2V6UUNBVlM1M0kzNW8yZDRmUlg5VmttbWE5MllK?=
 =?utf-8?B?bHpSbllxRnU0c1N1cDFkNEtJb2NyM0Z3ZC9TUmJreml6MStFZDg5N0owdjdU?=
 =?utf-8?B?NkhBQlo1cmxEL0hXQkV6akVtZjRBVi9LU1FFb0NKWVlhVkM3WHFrK1ZRclRY?=
 =?utf-8?B?c1FyYWQvKzNnb2N0TkxoZHZPUnQ0clI4N0paR0JJVDI2WmIwYmpZenUzU3d1?=
 =?utf-8?B?WW1LcjQ2aDZocE16S1N0MUgxOFNQYVFOR0xza0VjRmcwRnJhL2hIWHRWRzU4?=
 =?utf-8?B?NlREeDF2VzBERkMwbXJTTlRsWE1TTTYzcWhVRjk0TXl0d2JKcHBSVXFsVDJV?=
 =?utf-8?B?eHFmWWREeTIyUjhHYUJ2RWd0YWZSQ09ENUR5NWtYQ2FuWEhtdEdKVFErTFpa?=
 =?utf-8?B?ZUdDdHR3RXR0RzV4K2cyN0kxUG1IcGNMTS9jdTNSMDFwQnV4T1oyTFRlYy9n?=
 =?utf-8?B?T2dIMVZ3dGV3VkN4RldZU1prL3dhYW5tS0Y5cHhKVC8weUVMM2pUbWR5eklN?=
 =?utf-8?B?WjFDSHpYbWRMM0xXdDZLVnM0M1Q4KzRvZndIaiszRFpSbWZDeG9ORjcrZm5K?=
 =?utf-8?B?QkhPb0lZdS8wSHVLTFJKUFA5V1RxNEp3bDJQR0ZhQ0w5L2JkcnJDVkg0bVZq?=
 =?utf-8?B?djIydksreDJXS0VaVEtscVowZElpRGJaZ25YZ2d4OXRtNk1Zdytsd05zZVhk?=
 =?utf-8?B?WmNYQ2tMK2hvTEZVemJqTGNzY1lpMXZsRFJzcVZ2cVNoZk41aVRYOU1PdGJp?=
 =?utf-8?B?NnVUbHZaUFgwVXJVUjQrdklxYzY5VndJWmV6dnp0Wm5PZ2paMW5WN2hLSTc4?=
 =?utf-8?B?KzlGdHByeE1QNjcyaHJqRHdYRk5ndGZqWDY3Yjlpa2ordUFBazNCb3NLQ3Ja?=
 =?utf-8?B?UkhRTjRMcE5FUFBsdlkybm0vRlV1eUZsa05Xb1R3bkdzczRvdXhmRG5yeGZN?=
 =?utf-8?B?ZGVRY3hRMzlJU3plZEV2OWZLaEtFbW5oUTk5VGVwVkRWdGc0cGdHZC9IVlB6?=
 =?utf-8?B?eDJXL3BkcGV4THZTUFI0NTJWQUFoNnljMU8vUCs3TFZhQTdxLy90UWVFUWoy?=
 =?utf-8?B?Wmd1SmRHdGQ2aWFrMUowQVl0aEdYME52cW1xZ1lqd2lmRGNhQXd3SXJjdzgw?=
 =?utf-8?B?c29RNWpSYndRQXB3cUllQUlGOU9tRERIMWdEWDc5SE4rRjdqYUh1TVhHd0s4?=
 =?utf-8?B?OFlJUXE0YTBOQkdTenNTZGhXdkZ2eVFFWndqeENqVDFmSUU5N3JxTk9YUWRo?=
 =?utf-8?B?RUM0bFArMmhhb3hOU2pMSkxBLzJtbVMrbFc2MVgrdWhUQkZXRFhIaFNCd2E2?=
 =?utf-8?B?eWFGd2NhU3dVdU1aYWJWeVFpczRVaFJVYjBQbjdCRndJOXVuOFFjNXJqTkFC?=
 =?utf-8?B?a1Y5QURoS1k2cTZnWEFlbUo2VUU1Zk05THlFa0pwZ3NsMXBaUGREZGsvWWd4?=
 =?utf-8?B?SkpnREpzelpKZ0lrdEdvUnFua3FPV2NVTE1nakJQdlF5SEdudFo4VWM5bWti?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B169178E7268143807B00A5D9FF5CEF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f65430-0c9d-4fb6-d041-08dbe678245d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:46:28.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CZI28hU9+GHaEb+AGFFG76wlcQgeyg6y3nK7ms1lhGyNLs6ZLUOhFg+ff9cQms66zkSexqaT7hdMm4MdczaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7339
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.739800-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4uHG2TKOWIkujLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2wCZxkTHxccnOo//J/EA1QRd2FPQEB0XO8my
        X5RK7cEU40fAZLZAhdT79LwU+dQAsO+xLATovPvrK09/T6AzbVkJfxXUWJFGS1VNlojpO42iXNa
        gpKKGTE59o5VFDc7L0KxFMg5vrQSlvGnp4kZisNRlckvO1m+JcqDCySWmQZNj9Ez/5IpHqp6hfl
        tTNJBk/LJr6/wz8l9wdF8BZ6EBXsEL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtAqYB
        E3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.739800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BF66CE080D81C0B84DD5014EA8E5761D4F1DD596DA1F74AFAEC2C30A16D574C42000:8
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTE2IGF0IDExOjAxICswODAwLCBTdGFubGV5IEpodSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBDaGFuZ2UgdGhlIG1haW50YWluZXIgb2YgTWVkaWFUZWsgVUZTIGhvb2tz
IHRvIFBldGVyIFdhbmcuDQo+IEluIHRoZSBtZWFudGltZSwgU3RhbmxleSBoYXMgYmVlbiBhc3Np
Z25lZCBhcyB0aGUgcmV2aWV3ZXIuDQo+IA0KPiBUaGUgb3JpZ2luYWwgbWFpbnRhaW5lciwgU3Rh
bmxleSBDaHUsIHdobyBjYW4gYmUgcmVhY2hlZCBhdA0KPiBzdGFubGV5LmNodUBtZWRpYXRlay5j
b20sIGhhcyBsZWZ0IE1lZGlhVGVrLA0KPiBzbyBwbGVhc2UgdXBkYXRlIHRoZSBlbWFpbCBhZGRy
ZXNzIGFjY29yZGluZ2x5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBKaHUgPGNodS5z
dGFubGV5QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBNQUlOVEFJTkVSUyB8IDMgKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBiZTFjYmM2YzIwNTkuLjRm
NmZiMzM1Nzk0NyAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5F
UlMNCj4gQEAgLTIyMTAyLDcgKzIyMTAyLDggQEAgUzoJTWFpbnRhaW5lZA0KPiAgRjoJZHJpdmVy
cy91ZnMvaG9zdC91ZnMtZXh5bm9zKg0KPiAgDQo+ICBVTklWRVJTQUwgRkxBU0ggU1RPUkFHRSBI
T1NUIENPTlRST0xMRVIgRFJJVkVSIE1FRElBVEVLIEhPT0tTDQo+IC1NOglTdGFubGV5IENodSA8
c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KPiArTToJUGV0ZXIgV2FuZyA8cGV0ZXIud2FuZ0Bt
ZWRpYXRlay5jb20+DQo+ICtSOglTdGFubGV5IEpodSA8Y2h1LnN0YW5sZXlAZ21haWwuY29tPg0K
PiAgTDoJbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmcNCj4gIEw6CWxpbnV4LW1lZGlhdGVrQGxp
c3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLQ0KPiBzdWJzY3JpYmVycykNCj4g
IFM6CU1haW50YWluZWQNCj4gLS0gDQo+IDIuMzQuMQ0KDQpTdGFubGV5IENodSA8c3RhbmxleS5j
aHVAbWVkaWF0ZWsuY29tPg0KYW5kDQpTdGFubGV5IEpodSA8Y2h1LnN0YW5sZXlAZ21haWwuY29t
Pg0KaXMgdGhlIHNhbWUgcGVyc29uIHdobyBsZWF2ZQ0KbWVkaWF0ZWsgYW5kIGNoYW5nZSBlbWFp
bC4NClRoYW5rcy4NCg0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgV2FuZyA8cGV0ZXIud2FuZ0BtZWRp
YXRlay5jb20+DQoNCg==
