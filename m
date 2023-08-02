Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884AC76C167
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHBAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHBAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:12:11 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC91FEF;
        Tue,  1 Aug 2023 17:12:09 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371NvCcc002712;
        Tue, 1 Aug 2023 17:11:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6VablYO8Ln4zpIIyH4eh4IvPBFnUpG2AJBXjyEIMKjg=;
 b=BD5gHV2C6+SKbLFHq1KZVsDm04VnQSfjUyMuu8q8vp1nplXuwXMcbmeakSc9+7o2nGl0
 QUMo5Mt4zV9KOtTcXTHs6pJMxV0e7QFv2lFnIGvxBDwwk+8M+llqBtI8MKLd+IOAkq9M
 iPDb9pBABW1efLha8fLa8KzTSS1+iC4yC4TRuWbwuqYOVCx9it3VwgzWtBavUP5MCocx
 2fhSjfFBzKd0KZBZvZxBVHc1FBHRWsQIgJzdzL+unHTUKdyZmY/Fg/6N45KD1bP+DyIG
 yDaYaN/rnbZTXQwcwdBAJVzstna2a9eykImRo6T/sYkcB8VgMCIkFrBrjlL//FZnsGDv IQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s5213pbas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 17:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690935115; bh=6VablYO8Ln4zpIIyH4eh4IvPBFnUpG2AJBXjyEIMKjg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZbKlVne7a2CsFh5QSOdnWyaJOB+fs7vw0vZow/mda/4E/IkStX4zORuwReQwgjwRk
         y9v51EaRrhY13i6TqVRNtwkTspNERAj2y5FD9jdjpVDF8qoRgbnY52d5UWSduwerTM
         +xPZ9zlpiwXYDFaxsr5JlM4Qx7ccm8iN8jOinN3Rqc7/Lh5Xqx7d3zoOVSDeaYjhrB
         VeK3RUzpRsoIOhIRkogUWhQ38LJ0D0EQ/2qlTo6COXBvl2IMmUbdxnzI82obgALGyl
         aBnd5QihNQJnDgeV6F022g8+h7FzB72wbDg5S3GmH1Nvb2IS3l3DF2yp1m0bt9Hdfk
         vCseN51U9VkWg==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2EC654058F;
        Wed,  2 Aug 2023 00:11:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C9140A009D;
        Wed,  2 Aug 2023 00:11:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tpu71gan;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 96B7B404B0;
        Wed,  2 Aug 2023 00:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGikr4zlOtvNYp6KTL1sHX2WdmnBQBpy6DkjOZmzWE2Y0pF820+oYm+ooTxkJZL5po1I2MITjyZH21FZE89gbDjc2nukylutQasIYbKYGea99dZ/aja726SnjwvcQkJc/C6ZVYqMRd39znyHgYQP1PEi1Xn0Fkqw1TPA2qH9WDrXx4v8ppCj/QUwKQo1IeLlA8gExjOq6wdk4syr78uQyRx4j6Csmg4hCbtSy1jLF2TvnBKEevSFv/ZToeqiUOGKUKCst/3QMFhRDIIqgl6n8qCXeS/7xiwF0Pb+4swvZ5b1zwRTM93Fs2p3Z1tyMdxlQ+C5yy2H9PMMvJkge9gIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VablYO8Ln4zpIIyH4eh4IvPBFnUpG2AJBXjyEIMKjg=;
 b=R5F4hF8q4LlFm3d/tVNu632zNRlffNk+bXoJz0tk62f3ey884ahNWLHAwt4IOqi6Y1QdA/6zdcTdccfsYGKN+J6zK9RIV4yFAb/gSaHKpM/xNfTVUs3iFUKIYuHz8r9EiZRNh2Q8v7YP6XnwFMvK2LHecZk8Y0ypwob9Sc1bbjbP343B9y5P0Ic6aiEIXtsF/ROqJ+j7infLemswAZqnXy6CRjMc1GdxzX3m+FQQijb2C3WbmeElvQUq1beHf/Pm75FtaTXSbGxqNoQmYdov81ZceTdxHLRdEDfDlirmdWfxGzKzn3dvl8kuf4Ydyz9uRDFjPnXJY1pqRzNtLVlpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VablYO8Ln4zpIIyH4eh4IvPBFnUpG2AJBXjyEIMKjg=;
 b=tpu71gan1u0if9lcGGiW769SjucQt/ARgXQUTvyq/aS7IIeSxolGsCbKD0grnj04GciTQbJxwmJTt1C9cJEFJpItffSfqZMy1P9kzxet54TmE7om9yAqfs4Re5+W/tjvG0E+Md1B9envnmgO375SJZcH6Ok82J7e2LSZLmpqPCU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 00:11:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::588e:6476:a6eb:d698]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::588e:6476:a6eb:d698%4]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 00:11:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "surong.pang@unisoc.com" <surong.pang@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Properly handle processing of pending events
Thread-Topic: [PATCH] usb: dwc3: Properly handle processing of pending events
Thread-Index: AQHZxK4vd0fGGXvxU025rJI2BMKXn6/WIm2A
Date:   Wed, 2 Aug 2023 00:11:47 +0000
Message-ID: <20230802001133.wewz3xttineeil6v@synopsys.com>
References: <20230801192658.19275-1-quic_eserrao@quicinc.com>
In-Reply-To: <20230801192658.19275-1-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB5979:EE_
x-ms-office365-filtering-correlation-id: 73f0c93b-e899-4784-8d81-08db92ed1043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NiUKgbSJ6Q9pt3vD1UF/z5a2HPxCFyMv2heQH2TfTtEvIIcpCXASsm7YCzjSWXf51gPXvv8/1UtGpsBFtbw/SUd349cyLMB4RI3KeG0dLcWzVBGNMhWJ/er6jhKMS9it3NW4UpJc9WmWE9/H721+7dDWsMszNUX7l5f2sxWn7fDMqIcPMlg03mH+eQVuMHHefLVaCo9ynNukgGpP9/tokrgB6659q+Q3VoTguNX8DXeqAvHHu8Z8/IDth2UV4hrAvl6+VpYAE2iStw1tAsE3jvdmzEhdeIJCXNxuAnzeEyb19LUi/nrfyV+8BYqsN1sQY1ddZq21VtI2jhz0rLQto4F3PDCxdmUL2kBOmPSQYj3cCChCfsWKjR2Opf4njlY2xh2cwR+b9elgWmtA+1Pfd3NfsqHTijJjhPhZQT+nWnbGL4sNE7x5Yvz7Qz3q16/YI4AXlt9qz1jej28DTRFpOxsEsqXJ9ymz0z3rzcKtn0vrst/HeaSe5arlberxT4mjv0zRQDDJdBhALveKqKS8VQeNPn3SEoHpCKkroxGAzVow6/A/Stj1Lk6uyMf1eir1wloOG3ImmoCjZh41HbuWOLRYJ+dur2SLF691Mb7ZYhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(2616005)(36756003)(966005)(6512007)(316002)(478600001)(122000001)(86362001)(54906003)(38100700002)(66946007)(66556008)(66476007)(66446008)(76116006)(91956017)(71200400001)(64756008)(6486002)(6916009)(4326008)(26005)(1076003)(6506007)(41300700001)(8676002)(8936002)(38070700005)(7416002)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDA5V0RVQS8zRnRIQmcvUUdRUFRxN2lmc1hUb1Rnbm82Q2Q4MzAxOXJuK3lr?=
 =?utf-8?B?WUdYMUpNQjdLWmpJZEQ2dSsvMkNBc0tHRUZWZWZuQW1kckZVZ1lWRmhYTDM4?=
 =?utf-8?B?NVhGTWovVndOTHpFODJ6THVJWm1NdTVLK3pjL2lQVy9RaFBhZUp4dXpVSDFC?=
 =?utf-8?B?NjBoQStDYkJ4MTlvbGxYQjhmdEJsUlBXOXBIMjVhNlFoaDlIUEdoSS80UHFm?=
 =?utf-8?B?aDJUSmRIaitVUE95QkZudnNnR0V6ZUJZUXpCbjNtd09oZ0lNc0lWeWw3SmVm?=
 =?utf-8?B?QjU3UmZQbkJhZEQ5UkxmM0phTGZCdTZsQnVpNHVJLzdDWEwrb1JScEs2QkRs?=
 =?utf-8?B?OFUrdi93dSs5ZW5Sci91ZWREZlRWQ0lzWk50ZG5uRVNFNXF6Tk82MVZsOXVT?=
 =?utf-8?B?eTg2eFI4VUpBZ1NUNlM2d3hSeWVmNE8zZlJOSXFGZm1sR01JaHRZYzh6bHd6?=
 =?utf-8?B?ZzZ2bElKVm1LVlJZVS9remlBWDMrSjdGV3lsT0RKNUUrUnJDbDhoa08wOVc1?=
 =?utf-8?B?WnFycm0vbHZKV1poU1NQREw2T1h0M01sNGNKUmVVNnZxQTZZbnZFWExNYzR6?=
 =?utf-8?B?dWQ4STcwbGFkZkNCVXBsTDl1OXVZTHc5S0ZZM1hKdk1HWG9reVRwaEZjaDNq?=
 =?utf-8?B?eDlDcmtWZ2V0TjQ2ckJTNW9YTHpBdUFpV0xwcGVtdmZDR3E2cGdUM1pGbk1C?=
 =?utf-8?B?NEFGay90NTJjNzI1YVRyRmh6QjdHV2xHR0FLTUd2eG9ZQzdVSUw2NU9KMnhs?=
 =?utf-8?B?MTRvOFprV0hXcTJ3WXJVMUlLV0llL3RnWURjZjVGZzhEL1NmRk5LTHp0d0gx?=
 =?utf-8?B?bXJGcjdxMlhZbmFheGcwbmgxeG5JVHZ1VXZVeGkxeS9nS3ZjRDlJanVkK2Jq?=
 =?utf-8?B?Q3c3WEQ1aldHckN5T1dNN01kVzhqWlhjZ09mKzU0VEp2TzRQajgxRXh4UlhJ?=
 =?utf-8?B?T1hTSzZNdDZyYlp0K1VKVXI0UXVWRXZqb3VoaUtrbVFOcG80OXlHSzh4VmVT?=
 =?utf-8?B?dGUwMklISGpZQ2NBdTczdmI1eWdId3lJZUFiZ2g3L0kvZk9ZV1FqWHBLMmNj?=
 =?utf-8?B?YkQxeG5POXYxdnh3SGJHYzZxZlpxM2FMMmZvRWlkUmpSUUhVTXcvZjFmR21w?=
 =?utf-8?B?ZmhtWkhoSnl0MllrQ0dJTjQ0TktiOXlnYVk3WnZRREd4S0VLcEpUTHZIVGJs?=
 =?utf-8?B?d1haNTFiTGEwRElKcmFGK1FVNnJ2NEFFUG9XclllcHRDNkNsMzJaZVdLN3Aw?=
 =?utf-8?B?WmRnMTJyV21IVlNmc2huSklKaERmWG9QN2tsWjJVK3JNcVRsTkN0ZmtFZTl5?=
 =?utf-8?B?TThkM0YzRjBBMDVpYjRaWmkzMDA4WHFtbWh6ZFVEWm50SFFybXQwdGJyR1gx?=
 =?utf-8?B?UlNtRWdCZVVTQXozeFVFTGNNMU90SHFMNkM5cDBZeDBYRHNuK1R6NlpYY25l?=
 =?utf-8?B?cnF1bUVYRE56RDJMcEx2WG14cm96VkJ6Z0dPMGYwcTBPSGNVSHJMUE52RXR2?=
 =?utf-8?B?eUJEOE5RU29xU3B4SnV6VkJURlhhbk8vZ0NObnZhbUFmRVRpL1hNdjhzbWUy?=
 =?utf-8?B?eVBGL0p0UWljZXRsVnljQ0tGMjBVTk01TC95NlFGSkVldEIwdUtLTDdLNWhL?=
 =?utf-8?B?NGl1RzJGblFPbzlmcWJNZ21NNmF4em5hbW8wUFJ1cW9kbXFXVW1FcFU3WEl4?=
 =?utf-8?B?MlhELzVwNXRZT1BwNnlFTFFZa1ExZFozWXREdjN4WUxXem1Sb1cxaUc4cXdN?=
 =?utf-8?B?cGZ2d0ZTQVNVU0lLTkJGQ3BTWmsxbFlxU3pjZXUwS0I5bUhHT3NvdlN5ckRG?=
 =?utf-8?B?elEwZFFtc2x2Sy9XQ2hzK0ljd3BiYXRMK1ZWaEtQdjFESHp6dXhPREN5Y20v?=
 =?utf-8?B?Rm1rWW4zbEVvb3RIVXYwbml1c25FRm5heVBiTjNCSFM0WTdFRmFjeWlMcm9O?=
 =?utf-8?B?TEhJOGI1VGpXenBBNWdqdFVnVUg3WXkyQzk5L2J4V20rWExSdFU0c1JkN1hD?=
 =?utf-8?B?UU9HTFQwVW01K3BqYmEyeTZRTnBoc1lBOGhabTJ5ZEpSNzFqeXBTOEFkWm1T?=
 =?utf-8?B?TkhyWkxGYTlkTzBlNHRmcE5YQmZ4Kzgrb0sxeC9CUTRLSXZ3M3h4YlkvWmJY?=
 =?utf-8?Q?RVz3BFSIAZ/hzn6Yui+ztcFm2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFC9A005B1686F43BBF30B29AB668A8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDQzRnFCanVVSjJTOEhuUFptM0pUdFkrUGRqcFk3T2hLNVdNWnRNS2h5NWlP?=
 =?utf-8?B?V1lDOWNaTDBUZ1AzdVFlR2FDUTErV0lwQlZRR095T08wVUNpakZ4bkNsRUlU?=
 =?utf-8?B?cTlpQ1RKbDRZd25ienZGM21VSXVZeTA0aVAxREY3SDNzbExYWjJ3c2VWMGFQ?=
 =?utf-8?B?NHNvMWFFL2ViOVYzV2VJUWpZaG16Q0pibzE2MkhoQ3lQZ0d1Z1Y0amJMMkpE?=
 =?utf-8?B?SU5Pa3VQN2Zidm9iUjREYnpaeGZjdG1lKy9NeXNkYXBCSDhLaVZPeDh2WEFu?=
 =?utf-8?B?cm9Zbzl3MVVTVkc3RGJEQ1R4em05OHRkNlFDVjFWeEVQZ3lIdlJOR2tHVGEz?=
 =?utf-8?B?RlVBLzVZV1lGcFpBMFZjT0NhNk1sMG9jV3Y2QUc2YU9zUzNZb1MvTFArUU9I?=
 =?utf-8?B?eU9jKzVIRm4wdHNiOVBPejlra29ZLzBQTUEwbWNmWW5XdHFNMTZVYTIva2lq?=
 =?utf-8?B?VXVLRk0xWjNubWttOTlEeDZtY1FRSFBqVlEzQ0JXT2IxYUZFYml3REdjRmVh?=
 =?utf-8?B?VVAxdXFqRGxyTDhCc0RlUzBaUUc3NExhcnN6eEZHbmdvcThqam5vTUgyMGRY?=
 =?utf-8?B?OUtIZGZsNXpLcytMWEVsZzE3TEtTRXVZTzdSbHJVWWFKNGJ1WHlVd1VOSjNJ?=
 =?utf-8?B?Rll0T2RIUEhXU3BtQks0VUJwbFk0SVd2NHdsdVVzS1VYOEZWd3dqb3V5cDFu?=
 =?utf-8?B?MlVjWUdWUkFrZHlONFpOU2l0WkZFclRvWlBRY3FHSFFabmUrWlkrZnQxSmJh?=
 =?utf-8?B?OWViWFdJS0pFNUdIcDNvTWJCL08zbGROd2RBM1FXVGdBbktDTTNsSUZhSXZR?=
 =?utf-8?B?djBwU3dQcWthS3BVYWVpcmRid1plcDM4dUkxc3hORmhJMEFNOXVLazdQdjRu?=
 =?utf-8?B?dFhQdnVFYTl1aGVvTC9oVnVOR2tnMFZQWmh3czdIUGRBZytXU1RDWWc2dk1s?=
 =?utf-8?B?eUFkSElwbEdSVGFCVlBYTE15Yzd3V1lpNERacFJrRHlHMDJUWTJyL3N1Lysx?=
 =?utf-8?B?WHgvUStISHN4cllVbXZZSElQOXhiTzBMbXNBVEF6OGVWOHRoU1JxaHRPV2NK?=
 =?utf-8?B?WVlTdWJETDR3cGlYN1dyUXErck1vV2gvSTF4azlIdDR0a1hqN1ljYVlXcmUr?=
 =?utf-8?B?WWt6enJQSWM4VXFlTDAvNVZmMkRWQzBCcGIwTE1ibEZhRlJCNkVQak9SbXNO?=
 =?utf-8?B?OVp5WXlWcWhOUGVJZk4vWG1BOWRFRzFYUFlGTEIyNEZPdzY1RXdJUDFOOU8x?=
 =?utf-8?B?Y0dDRXA0aG1xMzd3OTVtSXkya3c1NFY2WW5odWlGYVhQaGZoODFlT0M0a2dC?=
 =?utf-8?Q?93ERSep0RaJdM=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0c93b-e899-4784-8d81-08db92ed1043
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 00:11:48.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rkdakrYJ/e6AxzPJ8TkY8X8OfokrgU5t3/0ZcccTzEg64sTucYvhPCdb9GGhiCwi6aKKQmgTwpH9hkBKZPUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Proofpoint-GUID: 9SjHUXBBJ9lC7yuVWymFSZimL5nldDdh
X-Proofpoint-ORIG-GUID: 9SjHUXBBJ9lC7yuVWymFSZimL5nldDdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_21,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=659 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IElmIGR3YzMg
aXMgcnVudGltZSBzdXNwZW5kZWQgd2UgZGVmZXIgcHJvY2Vzc2luZyB0aGUgZXZlbnQgYnVmZmVy
DQo+IHVudGlsIHJlc3VtZSwgYnkgc2V0dGluZyB0aGUgcGVuZGluZ19ldmVudHMgZmxhZy4gU2V0
IHRoaXMgZmxhZyBiZWZvcmUNCj4gdHJpZ2dlcmluZyByZXN1bWUgdG8gYXZvaWQgcmFjZSB3aXRo
IHRoZSBydW50aW1lIHJlc3VtZSBjYWxsYmFjay4NCj4gDQo+IFdoaWxlIGhhbmRsaW5nIHRoZSBw
ZW5kaW5nIGV2ZW50cywgaW4gYWRkaXRpb24gdG8gY2hlY2tpbmcgdGhlIGV2ZW50DQo+IGJ1ZmZl
ciB3ZSBhbHNvIG5lZWQgdG8gcHJvY2VzcyBpdC4gSGFuZGxlIHRoaXMgYnkgZXhwbGljaXRseSBj
YWxsaW5nDQo+IGR3YzNfdGhyZWFkX2ludGVycnVwdCgpLiBBbHNvIGJhbGFuY2UgdGhlIHJ1bnRp
bWUgcG0gZ2V0KCkgb3BlcmF0aW9uDQo+IHRoYXQgdHJpZ2dlcmVkIHRoaXMgcHJvY2Vzc2luZy4N
Cj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBmYzhiYjkxYmM4M2Ug
KCJ1c2I6IGR3YzM6IGltcGxlbWVudCBydW50aW1lIFBNIikNCj4gU2lnbmVkLW9mZi1ieTogRWxz
b24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gQ2hhbmdl
IHNlcGFyYXRlZCBmcm9tIGJlbG93IHNlcmllcyBhcyBhbiBpbmRlcGVuZGVudCBmaXggYmFzZWQg
b24gdGhlDQo+IGVhcmxpZXIgZGlzY3Vzc2lvbg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2JlNTc1MTFkLTIwMDUtYTFmNS1kNWE1LTgw
OWU3MTAyOWFlY0BxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchWXRaOTNBTEVwRE5UQ0VoZjBX
RXlCNVMwOTBwUGxLSUtWdGpxVE9BRUpkeGRXYmw4UUc2ZWlSbWx2Zml2VXRENXFqS1dXTFgyQzRm
YjRXOFZBZzV3OXFhc0x1S0IkIA0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA5
ICsrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDVmZDA2NzE1MWZiZi4uODU4ZmU0YzI5OWI3
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ0NTUsOSArNDQ1NSwxNCBAQCBzdGF0aWMgaXJx
cmV0dXJuX3QgZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpl
dnQpDQo+ICAJdTMyIGNvdW50Ow0KPiAgDQo+ICAJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3
Yy0+ZGV2KSkgew0KPiArCQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gdHJ1ZTsNCj4gKwkJLyoNCj4g
KwkJICogVHJpZ2dlciBydW50aW1lIHJlc3VtZS4gVGhlIGdldCgpIGZ1bmN0aW9uIHdpbGwgYmUg
YmFsYW5jZWQNCj4gKwkJICogYWZ0ZXIgcHJvY2Vzc2luZyB0aGUgcGVuZGluZyBldmVudHMgaW4g
ZHdjM19wcm9jZXNzX3BlbmRpbmcNCj4gKwkJICogZXZlbnRzKCkuDQo+ICsJCSAqLw0KPiAgCQlw
bV9ydW50aW1lX2dldChkd2MtPmRldik7DQo+ICAJCWRpc2FibGVfaXJxX25vc3luYyhkd2MtPmly
cV9nYWRnZXQpOw0KPiAtCQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gdHJ1ZTsNCj4gIAkJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiAgCX0NCj4gIA0KPiBAQCAtNDcxOCw2ICs0NzIzLDggQEAgdm9pZCBk
d2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7
DQo+ICAJaWYgKGR3Yy0+cGVuZGluZ19ldmVudHMpIHsNCj4gIAkJZHdjM19pbnRlcnJ1cHQoZHdj
LT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7DQo+ICsJCWR3YzNfdGhyZWFkX2ludGVycnVwdChk
d2MtPmlycV9nYWRnZXQsIGR3Yy0+ZXZfYnVmKTsNCj4gKwkJcG1fcnVudGltZV9wdXQoZHdjLT5k
ZXYpOw0KPiAgCQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gZmFsc2U7DQo+ICAJCWVuYWJsZV9pcnEo
ZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIAl9DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNClRoaXMgZml4
IGlzIG1vcmUgY29tcGxldGUuDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
