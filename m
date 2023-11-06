Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D047E2D40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjKFTzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:55:36 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A65D47;
        Mon,  6 Nov 2023 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2636; q=dns/txt; s=iport;
  t=1699300533; x=1700510133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CWXvA5YKa21VJasesEdTgMMbycYfH31WgJXsQhQRRiQ=;
  b=kQZNvgpE+S76D6ZpmvvEGZSiKfNKSfNuOZL8nmtwa+HMyOfdpoSdQPqi
   I8+KzL0lxchAIswXECPgL7LMFWlolMRQeC+OGqs01bMpfMuLuRnWdMKrm
   SxWBDTA+GFvSpjtsQXmDWIzNokBDb3X3mKjhYMZ6EsPBjNxIOsboxcQ+d
   o=;
X-CSE-ConnectionGUID: IDqiYmxtQyyONEvQW9cC3Q==
X-CSE-MsgGUID: 6pOX4QUNRRydBBGEBOxR8A==
X-IPAS-Result: =?us-ascii?q?A0AbAADEQ0llmJhdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ4WzxIhFKDTAOETl+IYgOdfhSBEQNWDwEBAQ0BAUQEAQGFB?=
 =?us-ascii?q?gIWhxACJjQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBA?=
 =?us-ascii?q?QEBHhkFEA4nhWgNCIZEAQEBAQMSEQQNDAEBNwEPAgEIDgoCAiYCAgIwFRACB?=
 =?us-ascii?q?AENBQgaglyCXwMBoGIBgUACiih6fzOBAYIJAQEGBAWybAmBGi4BiAkBgVCIN?=
 =?us-ascii?q?icbgg2BV4JoPoJhAoErARIBIxWDRDmCL4kuBzKCIoMrKY0MCXdHcBsDBwOBA?=
 =?us-ascii?q?BArBwQwGwcGCRQtIwZRBC0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYC?=
 =?us-ascii?q?RUMNUp2ECoEFBeBEQRqBRgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA?=
 =?us-ascii?q?0IGSQsDAhoFAwMEgTYFDR4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADb?=
 =?us-ascii?q?B82CTwPDB8CGx4NJygCNUMDEQUSAhgDHgNEHUADC209NRQbBQQ7KVkFoDNqP?=
 =?us-ascii?q?VJ7NUg1EQEBHUWSToMWSa4zCoQMoT8XhAGMc5kMmD4ggi+lWQIEAgQFAg4BA?=
 =?us-ascii?q?QaBYzprcHAVgyJSGQ+OIAwNCYNWj3l2OwIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:E9VDMR+kHSUrOf9uWO3oyV9kXcBvk6//MghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqNgNvOuXxE436hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:1AUEoKIurD8YjnV4FE+R7JUlxSXFcZb7ZxGr2PjKsXjdYENSg2cEz
 WAXDz3QafvYM2XxL9l+YduwpE8E6MXSy9ViHgId+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8gmYqajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFYxq4b72JGijiN2C6GvrbULTkv5FV3hjaOX0+s4vaY1P3
 eYTJDZIZReZiqfvhrm6UeJrwM8kKaEHPqtG5Somlm6fXK1gGM2ZK0nJzYcwMDMYhclUAffab
 skxYjt0ZxOGaBpKUrsSIMtlxr3z3yKuIlW0rnrLvY0Hv1Hu6jZLwbTHGvX4UPuaf5V8yxPwS
 mXupjSlXU5y2Mak4T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+fV+6p+Spz1W1QNN3N
 UMZ4GwtoLI0+UjtScPyNyBUu1aetRIaHtFXCeB/sUeGy7Hf5ECSAW1soiN9hMIOleMvRA0vx
 kOwjsLOIxFxiYLEQlnGz+LBxd+tAhQ9IWgHbC4CaAIK5dj/vY0+5i4jqP4+TsZZafWoSVnNL
 yC2QDsW3OpM0JZav0mv1RWW3GL2/8mhohsdv12PBgqYAhVFiJlJjrFEBHDB5vpGaY2eVFTE5
 T4PmtOV66YFCpTleM2xrAclQurBCxWtaWC0bbtT838Jq23FF5mLJtA43d2GDB01WvvogBewC
 KMphStf5YVIIFyhZrJtboS6BqwClPaxRI60C6yINooTOvCdkTNrGgkwPSZ8OEizyCARfV0XZ
 f93jO71Vy9BUPQ7pNZIb71FiOFDKt8CKZP7HMCnkEvPPUu2b3+OQrBNK0qVcu0898u5TPb9r
 b5i2z+x40wHCoXWO3CPmaZKdABiBSZgX/je9ZcIHtNv1yI7QgnN/deLn+N4E2Gk9owI/tr1E
 oaVARQHkAOv1CKYc21nqBlLMdvSYHq2llpiVQQENlez0H9laoGqhJrzvbNuFVX73ISPFcJJc
 sQ=
IronPort-HdrOrdr: A9a23:9qYQ1q8fy67QpJV5LQZuk+Gddr1zdoMgy1knxilNoENuA6+lfp
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
X-Talos-CUID: 9a23:CnuS8mwTI9UfpjtJgK64BgU1NtkkQ3jN0E7BMmieJHhQd+yeYgSprfY=
X-Talos-MUID: 9a23:cXsyDwkv7jvpUmKKG3Zldno8LOBYv52TLno3gJkskeapHwtgAWe02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:55:32 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6JtVpk020161
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:55:32 GMT
X-CSE-ConnectionGUID: YvuIHXxlT/Oewox8FrDxwA==
X-CSE-MsgGUID: Wliwa3aMQ6aLEZlVBvH58A==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7047238"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HamsTH1/mo7b8RV0pUhukZYr0H0/N7728NVDjlONCQTMZVSDuNihfq7I29c1ieGJjBs1yjwI9h9HOszqRySD8mt8+rq+hOswmaKvRmwqCWEc+NiYVq5P44APYmAXOF5Ivh8F3/CFi78GZfdm3LrNF6/G+Ehy+t/XIyQ7F4ANHIdEPYAOSsuHp8Cp3liegPeXU5wrvumEJvUet7FYGhERq5+FwELJh+BLqKLE6D6ex6MSuTnzvTpHecdM2eIoGtGbTtSUEFSY9Rj1cWzbSaSQf8WAk95aOEKuStqCsVi8QmhiJzXpSlQ1LekVOb7iW89ntzyYLeYSf6DFoX3bOAjr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWXvA5YKa21VJasesEdTgMMbycYfH31WgJXsQhQRRiQ=;
 b=ThU74dhikKseY445X3vYToPVZvC2qzKKMXH4OPIzQDW3a65YC/h9NrEikILKGgyJoj6tOzspQVZccdxjgKmDUNifPXy2ye1IaEOxxG6LTmgYAbubNcDMxjpohaXWOzLjivTQnWfbani8AWPIVozdeJbaykONd7ihU3NUzoeuDxBJDXIcSnF7lk02m/xruNvKbDJQqmRu6fu4z89j1zq2SD5vaEfCF1anL/YT+M6KVKuROiMufBgHGr+hTP8FGaTut88iLXaYWlYeU4vMd79BSXinjexd4+NsaYZDij64ZrhS9Py9W2Efe53AAtVNT70L3WUoZPxjo7/mgxbMxLES3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWXvA5YKa21VJasesEdTgMMbycYfH31WgJXsQhQRRiQ=;
 b=HmAIj/gj0/IhgWJCf+7ruf/MFKQ8z+hsl8aKJKAeRMZTMSowTP02jjsPFHyXGEGxERe4+I7Zjj9G4GopD7y8Hl3SD0ZstqnvhLR63bBtNcpm2mkPF5+JOKjTI1JinvIV2Cr1uWFkaM+9uaCT2xIYn0cMMT1QGnUa72LkxAcPkho=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 19:55:30 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:55:30 +0000
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
Subject: RE: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Thread-Topic: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Thread-Index: AQHaCP/qh3b6PTh+8EGi8tSfqgAnobBmqi6AgAcYxLA=
Date:   Mon, 6 Nov 2023 19:55:30 +0000
Message-ID: <SJ0PR11MB58960545FE72C28A91D3585AC3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-4-kartilak@cisco.com>
 <41c2fd4c-f6b3-450f-87b3-d059d52ba2f0@suse.de>
In-Reply-To: <41c2fd4c-f6b3-450f-87b3-d059d52ba2f0@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DS0PR11MB7879:EE_
x-ms-office365-filtering-correlation-id: 00eb6f35-64d3-4838-62ed-08dbdf025471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEBO3j/4PSoWrUHYFFQ3/G/USla/qgYDpPOPtTib5at+Q/wJnHcRm56kS+IVOYe6gQEwo4xRygOGkz2tbwUseoXEyG+9TnmWdv9316hAlBmN5KWx3afYdhbF18bGlZUlXhl1ICWH/NDMhEBJ7IRNZtMqB2HOURDsr/oI+jWyWt0CWHvsPUAg6cr18ExrYR0wvaj/hD4qEdQuSovQC235KO6vnTyUKRZEOHUUI+KMvwEy1QcGxTizzHevNtyWMUNWkuJAYeKVt7+TVci2H0KzYjB0eJhG0EJP0WztUjUcqFENc+Q3doNPMSr2DJj4ZuE6fYIH0fFmqrz6rAAlX9bYp4WNR7Mi1lmnJsa21K+uMkdgtc+z5bXfDs9G2jv7FlKsyscstNcCmBRahxDBk+WyE4wrRTVDLoFclpKbaecMOVSWv/M/vt/RisXfXOc7XcUTkz6XGK1E/0TggrdXhBj94SCGnBcJt71ePSnDpbDOrYaCdUuMKItWDdgmjaLu/07iPy+tjERKrJ7RGYvY29PmumcpDY3KyvVr8DjwFnqgStgDdbgdKTNdUUHxIA5uRiJJBYOyyLvScz3bDEgmMHLmDoth7aeX9mJ3jBVBxQ1mHThFJFJh0nwdVuTWkjWV1Jqd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(38100700002)(7696005)(71200400001)(6506007)(53546011)(83380400001)(9686003)(122000001)(41300700001)(86362001)(4744005)(33656002)(15650500001)(2906002)(5660300002)(8936002)(8676002)(66946007)(52536014)(4326008)(64756008)(54906003)(66556008)(66446008)(76116006)(66476007)(316002)(6636002)(110136005)(478600001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm9jTXFna2l3WjlSb2tFTjFnWUJkREZqUk9HcjlJOVRpZk5vL0tUTVdjYjNZ?=
 =?utf-8?B?NUxIS1NWWkVYWWZJSGQ3QkhUd21ENW1zbllOUVBDNEFzWExpWDcwWjRTSXBj?=
 =?utf-8?B?TDk0Qm9IZllLbTUxKzc1UmNVcjZOUnA3RHFYUmpEQlUwUy9CcDlEMWU4UFRO?=
 =?utf-8?B?RlJpV0l0Vk5NNG9KcEtVS0FST1A2WnZCMVVIeWVmVGZ0MDVHSmQzcTExQ3Fa?=
 =?utf-8?B?SVdla3U0OFVOckwwWWoyV1AzMjc3b3F3Y2N6MXYyZU5rb0FqN0Z5Uk5yTnk4?=
 =?utf-8?B?cXpXV2RTTEE5Vi9vRzJtVCthcG40Zjd3eEJYVnJSVXNCQW9OM1IyK2txeEF5?=
 =?utf-8?B?blNpQklnVmZFWHFqeDBpTFpaRGVBcXh1UFBuTmZUOHVXSGFGQ0NNOFd2b2M2?=
 =?utf-8?B?NGlRV3Q3b2hEb0RJdGdOQWE3S0ZDUnIvQ3FMNWhBNUxQemtvY0FTd1VrejNN?=
 =?utf-8?B?ZkhjVlBDbE5jbnByT0s0QmswRGZGekZmRzNWYk5od0J1b1VjWnM1clUvTTRC?=
 =?utf-8?B?Y3hJNWh1S2l6MVM0ZFB1aktNN2xSVjkwMGdySE8ydDlDTXVpd3hxell2M01D?=
 =?utf-8?B?TTB1ZWF6UHEyc0xWQXpLT1NmRGlDSWFXOTZpd3RVcFQyWjFLK0hoTDFHWkJU?=
 =?utf-8?B?UFRsVW5Sa3ZpRkpDZzhIc2I4VVJHSmgzcHZSSnlPSXZkVDFHeDNDOVFpTWF3?=
 =?utf-8?B?OTRvcVdQVndnMHlmR2lvQ3RSUzJiOFZROXpsMFplNEYxaEV1bnFwSms2MFBa?=
 =?utf-8?B?MlRpOHhFbGd5SUhJcjFMMWFiOE9tNE9jZkQ4U3V6aXVDM0RZaG9BdWNmSUtZ?=
 =?utf-8?B?c3Q1VUNNZ2czOWd1aHZ5b0ZsTk1kanFLQXFhT1lwa2N1N1Via05GWXlOWFlz?=
 =?utf-8?B?K21TaWlNRXBXeERDeFlhSXVOTUNNOWVzd2hWRmhXclQrMWRLY0ZOaEQxRmJh?=
 =?utf-8?B?a2ZsSnVWWFA2UmZ6b2dMN21GZHkxdXkvS3F5Q0dxZXFvenUranJmSWNJUndQ?=
 =?utf-8?B?SGdvK3IwYjJZbW1aZTBYYVVCd1FNMktzTUNPNlRrblBQT3VZS1JrMVN2Q0U4?=
 =?utf-8?B?ZmRPdTBWbFQyVUtwWUtlek4wTlJnTUkvZ0xaWUFxY2RGbVZ5RlBwTGs0Nzls?=
 =?utf-8?B?VlVXRTFDcVlUQ2ZXVExqOUQxSzBCU0VJY1h3V1NVTlNjbFlOSXB2NXJHUmFi?=
 =?utf-8?B?aTB0Uzl6ZUp0L3huYnJUaWtkcG8rM2tHc0ZKeDdURE1HY0paQXBxNDRpcnp3?=
 =?utf-8?B?Y1hPR2VFdUM4a2Q1SXhGRHFBUkpiTFpScnNaY2EvQUIwU04xMEpzSmtFclIz?=
 =?utf-8?B?UXpHcHBiMEM5NHFaY0pEWFEyMk8yMGltdlpvMEcvYllWZ2RsTjRTSWxBMUhE?=
 =?utf-8?B?ZjdaWXBHTEF1NVAxU2NFdmdOZmUvTGtqMFNHZnRjYnJvMmp4MjErY3lMK1cr?=
 =?utf-8?B?OHVpSGpOVUlHZis0NzNCYkhCdjlpbkFaTVVtZlZTbFRNSWtZYWhnaFFFdEpD?=
 =?utf-8?B?aVdKV3puUmtETTlSRjdnNCtzS25CSnBIb1RGMVJJMnNJbm56NHVlQUJlcmpi?=
 =?utf-8?B?SHBoSmthaFJPaitUYjJtNnBRaU5TTTBYRDNaQjJWNUZLS01EbWlpZ0Z5dVQv?=
 =?utf-8?B?R04yN0VKSSt4aGZwM2YwMzNFejBCY1hJVitXYy92bWhMekVuME80V2x4Q1lL?=
 =?utf-8?B?UDRZc1hWeER5MU8wRUhVTTkwUlUrUjREL1BBdjhack1Ua3pEdC9TblJVa2Rp?=
 =?utf-8?B?Q2xocUE4K3NORUhDSlloTXlQQ0hhVCtScE8xczM4SStMM3ByU29YS2Vvcmo3?=
 =?utf-8?B?UEs1WlU2MlR6ZFoxRGo1ODFOSUdieEowcTRNWW5NRk8zazY4Tk02ZWlhWUkr?=
 =?utf-8?B?ZUtyeE9pTS9qek12c0NRRENmcVlTYnRFZUx4NDl4TzJTQVYrdWUyWUpTRDJG?=
 =?utf-8?B?cE5Qa2J6M0pPYW03Q2daRW94bnhXTnk0VHFjbXUvdXpVTkp5V2ZNVkJpNWV6?=
 =?utf-8?B?WWFyM0ZaTm9PVkJ1SjVUNFJUSzFyN0U5QjJIb2tjV2hvMHcwcTlsR0owUW9s?=
 =?utf-8?B?ZU9sRXo2b1FtWEN6dCtqbWxPekdhcWZEYnlxV1lWdGJ4emlLZUVSU09xZldB?=
 =?utf-8?B?YnY0VzEydjVqNnFzUk84aXNrbytGcEluYjQzRVptL3c5Rk5rV3MrYU1QMWs4?=
 =?utf-8?Q?19+ABZ1LryjAzsPmBlhZXRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb6f35-64d3-4838-62ed-08dbdf025471
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:55:30.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbLYLnhv+voYcBpLC9G7uMMR448Xc0qJLcogtlgiWxEDlqwS7kASyYNI1JoxB/zbJN9NtrlisleVUhQ63/74tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MjggQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gT24gMTAvMjcvMjMgMjA6MDIsIEthcmFuIFRpbGFr
IEt1bWFyIHdyb3RlOg0KPiA+IEFkZCBsaW5rIHJlbGF0ZWQgbG9nIG1lc3NhZ2VzIGluIGZuaWNf
ZmNzLmMsIEltcHJvdmUgbG9nIG1lc3NhZ2UgaW4NCj4gPiBmbmljX2Zjcy5jLCBBZGQgbG9nIG1l
c3NhZ2UgaW4gdm5pY19kZXYuYy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBTZXNpZGhhciBCYWRk
ZWxhIDxzZWJhZGRlbEBjaXNjby5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFydWxwcmFiaHUgUG9u
bnVzYW15IDxhcnVscG9ubkBjaXNjby5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FyYW4gVGls
YWsgS3VtYXIgPGthcnRpbGFrQGNpc2NvLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc2Nz
aS9mbmljL2ZuaWNfZmNzLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0NCj4gPiAgIGRyaXZlcnMvc2NzaS9mbmljL3ZuaWNfZGV2LmMgfCAgNCArKysrDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9mbmljL2ZuaWNfZmNzLmMNCj4gPiBiL2RyaXZl
cnMvc2NzaS9mbmljL2ZuaWNfZmNzLmMgaW5kZXggNTU2MzJjNjdhOGYyLi4yMDNmZmVjNjI1YTQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zY3NpL2ZuaWMvZm5pY19mY3MuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvc2NzaS9mbmljL2ZuaWNfZmNzLmMNCj4gPiBAQCAtNjQsOCArNjQsOCBAQCB2b2lk
IGZuaWNfaGFuZGxlX2xpbmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgbmV3X3BvcnRfc3BlZWQpOw0KPiA+ICAgICBpZiAob2xkX3BvcnRfc3BlZWQg
IT0gbmV3X3BvcnRfc3BlZWQpDQo+ID4gICAgICAgICAgICAgRk5JQ19NQUlOX0RCRyhLRVJOX0lO
Rk8sIGZuaWMtPmxwb3J0LT5ob3N0LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAi
Q3VycmVudCB2bmljIHNwZWVkIHNldCB0byA6ICAlbGx1XG4iLA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICBuZXdfcG9ydF9zcGVlZCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJmbmljPCVkPjogJXM6ICVkOiBDdXJyZW50IHZuaWMgc3BlZWQgc2V0IHRvOiAlbGx1
XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBmbmljLT5mbmljX251bSwgX19m
dW5jX18sIF9fTElORV9fLCBuZXdfcG9ydF9zcGVlZCk7DQo+ID4NCj4gUGxlYXNlIHVwZGF0ZSBG
TklDX01BSU5fREJHKCkgdG8gdXNlIHRoZSAnZm5pYycgc3RydWN0dXJlIGFzIGFuIGFyZ3VtZW50
LCB0aGVuIHlvdSBkb24ndCBoYXZlIHRvIHByZWZpeCBhbGwgbWVzc2FnZXMgd2l0aCAnZm5pYzwl
ZD4nLg0KPg0KPiBDaGVlcnMsDQo+DQo+IEhhbm5lcw0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcg
Y29tbWVudHMsIEhhbm5lcy4gSSdsbCBtYWtlIHN1aXRhYmxlIGNoYW5nZXMgaW4gdjMuDQpQbGVh
c2UgYWR2aXNlIHdoZXRoZXIgSSdsbCBuZWVkIHRvIHN1cGVyc2VkZSB2MiB3aXRoIGEgImdpdCBz
ZW5kLWVtYWlsIC0taW4tcmVwbHktdG8iIHNvIHRoYXQgeW91ciAiUmV2aWV3ZWQtYnkiIHRhZyBm
b3Igb3RoZXIgcGF0Y2hlcyBnZXRzIHByZXNlcnZlZC4NCkknbSBub3QgZXhhY3RseSBzdXJlIGhv
dyB0aGUgcHJvY2VzcyB3b3Jrcy4gVGhlIGdvYWwgaXMgdG8gcmVkdWNlIHRoZSBudW1iZXIgb2Yg
cmUtcmV2aWV3cyBvZiBwYXRjaGVzLCBpZiBwb3NzaWJsZS4NCkFueSBwb2ludGVycyB3aXRoIHJl
c3BlY3QgdG8gdGhpcyB3aWxsIGhlbHAuDQoNClJlZ2FyZHMsDQpLYXJhbg0K
