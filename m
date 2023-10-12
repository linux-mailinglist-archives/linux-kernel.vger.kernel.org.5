Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17E7C75A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441945AbjJLSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbjJLSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:06:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3DA9;
        Thu, 12 Oct 2023 11:06:18 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHR5HV010279;
        Thu, 12 Oct 2023 11:06:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=NrXOG6GgHltCsC25DEiAK7EyB3IX+RrXxla1hOvuxPI=;
 b=OMyqcdBc1pzYYsC/uq2ccW3iGImJodXAXo6zwyse4httze/eEbyFaAJB/iqswTIiZEIJ
 TNpu5Nx2ZKuIJb82LLv8VGU2GCm6+rxPM/shjH8ZvJhMnfG0w+WpAophV2i2bICZaWXm
 ELYXItN76Kiru+cfdrJP0CCcDKEACczSyRzYhU+ou3GNuRvVdKSFCUAHs4pChdi3N7DY
 uCDV7L2qJ2F6JUXjPaI1IVvlXwxoljJZEyltUOyGk5pTXMYdt57kuT9edqV3+K2N/tmk
 eJmC84ByeHllFde8LsLBovzDYy35MIPt7AwY6TffqM5EpvZKCpZZi1ObNNxZW8VPCJYr tg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tkh041ndt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:06:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697133962; bh=NrXOG6GgHltCsC25DEiAK7EyB3IX+RrXxla1hOvuxPI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GBpxI59kv+mvBtnTg5cUYto1SOJoYDOnfzRBMM/ypAqCdyR4Z88rMJKVShV0WD0Yw
         WHOUNZ+xdSQwzBAJlPCecNI6itj/Lp/71wqsUnfyd+ORL67s2isq5V8HGc+P6RV0/z
         +tYbKnnMbiDCPnhrCoq3C0zZdOHgT5uTnFF5teziUSd2BOjPIHsj0aT1+fzi7q79r0
         pVAPdluESATnjsdwSJTLNZUjt+WuVE5kaa51bHGNMWbk3auZM6oQ5IbM59n7dr57m7
         vtbNgH7B+PIF2NG8uK3FQ4Jwxu8/Fxw381RjSU1nNZsoC6l9hmNccFFDJiOUWIrkvl
         5RZnUc3wRfIzA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 93D3740354;
        Thu, 12 Oct 2023 18:06:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AC50EA0070;
        Thu, 12 Oct 2023 18:06:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uUolzH0b;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 09D814048F;
        Thu, 12 Oct 2023 18:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9L+pe5oXxpiXv6qzscYMbI17DrhUaoTgfHPre7BUXWhvzCJdJskrugL92hGg4k1WnUKvT3CCqG/s8dUkBfDxojSPHDC0r8LlIsGrkSAG+cEwM1PjP4D2XwHeKgV32ANhjPDBP/K2LKnPIqQ5Vu7qlWc7OTzI/4no4t1L6FXao+4wiXMYAnHmoM6pAvXGy6TdCOLd+AO+Qiv1uJueGWKIAbqhuB0e8nFaJiYCK+skSvyiQV6x8KjVO8vElNuI4qx1M3hB+mHs3y/zXyZ63YNYvpSCp70G2MwGYndUIodT82GPdXWzJBCjKsFjjmvkzDDodaB0Xf0tvhWO8Z6bJdnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrXOG6GgHltCsC25DEiAK7EyB3IX+RrXxla1hOvuxPI=;
 b=BoigzfTyAoM+rqBlZL1zrbvx/6Ap4rQoS3CtGPi5oCn7u3OpUKbGAGysKF7TQaTYc6/CyKyepzadcYMdFkI5ivEn6BnRbT3ZpTwliRNjnG68KTZSXntI98jRjYgsM72AIrCmZZa9aGGY4/qvaYl3VSJFJtJAbRayMTdPpPTHO039uWqu8MUaG1NEewWACYu+WrYw1/gj4wqX7F4bYcPDXsmA98SEqt94+rcLolc/wyZFjsbDrBLfIpDVyLmKeydDcVEnvba6UZTVjJtvPXyFKLX/BBmKFvTQe9i+D4o9+xbDPNHE9nJthwUM8j1zZPnzr3FuI7vlt4+ogRjyBYNFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrXOG6GgHltCsC25DEiAK7EyB3IX+RrXxla1hOvuxPI=;
 b=uUolzH0bdy4LSfdKmSc9GvPMNV4yf0tDytmvBv+8++Ex8ZnVWiRxAq/B4Mk9H6MrhTEfg18wE61HjNPwi2KFf+M+YWF6WPaZdOw2iBLvm2Mw9lr0rrIKmADejTJRIR1fLPsRMMGvOr/xcp5dl1q6sGzKLQ52jbbmq+lcNkU82ZU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:05:54 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:05:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Piyush Mehta <piyush.mehta@amd.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH] usb: dwc3: xilinx: add reset-controller support
Thread-Topic: [PATCH] usb: dwc3: xilinx: add reset-controller support
Thread-Index: AQHZ95dx2gkxyWtEYU2dPhHrtquB27BGfjwA
Date:   Thu, 12 Oct 2023 18:05:54 +0000
Message-ID: <20231012180540.byvdiwtx7bgixidk@synopsys.com>
References: <20231005142215.1530-1-piyush.mehta@amd.com>
In-Reply-To: <20231005142215.1530-1-piyush.mehta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH2PR12MB4890:EE_
x-ms-office365-filtering-correlation-id: 2437b65a-4000-4327-cb7e-08dbcb4de0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIh9py9kaTE9mrFK2r+ClWAOmWu4F+CWizu9FWyXjvy3E+i75hHSbZFseLloxdaqEdqIV7JG0N+s3Zv+vIhgF2aA+1yW82ROpOKJiSuQWQk6fezHM1267CEneKzexbR6Wh7LVhdqaqbhx0ctHHxchISsyxuJ9ngMYP5SRrRNzVnevWPCo7GLFYW5SwzOtN6beiR/lqiZ2s2PHZEWjlVadARIsc0dbsICJ3P817CIh/asd6+evYMR3h2gdmsg9/6AWh1gv1UAqUJACsbNI5abUiAK0WvKh01EsNP9/Cb70UxdaUBU5XwIgVoepiWhYWTNwxV4xxX3jXCzul1bimWpHRiOpLQXz3NO2c24nVwq23E+XPsc9BV3jt9VuqQ762DI9Pr8324nvU7ULp0hEN/DL2a3vodyipvN0rSolvD3F41XB++7DVy4lAKy34V2/H8xAEqH39UbxRqa+X1t55NsAdegAbpPt4lg89GO9cNXa9YbauWdcvRRDByX0aojRSPAlvVVXTdAZ/yLQ7XwvRkTbYm9n9Md/s03IaylWciQuKD2UrCVAbTi7BabQI2T3ygycBhpYC0J3UQbvSA2XSyb1bOthGjqVgpc/F93M1HsAVB6B9JzP9z6zy3kGxPEEEVl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(38070700005)(38100700002)(6512007)(26005)(2616005)(1076003)(478600001)(8936002)(6486002)(5660300002)(4326008)(8676002)(86362001)(2906002)(6916009)(91956017)(316002)(66476007)(54906003)(64756008)(36756003)(41300700001)(66446008)(66946007)(66556008)(76116006)(71200400001)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFNWcGQ2N1I0NjVmd2FXMEpLcUxVdFJ4ZGVjT2JoYmExWndsYXlxVUJLNGVE?=
 =?utf-8?B?SWNYQTZEa1U4SEl4aUJxZmJjRDdFODlhMGtEVGkxd1phcFVZcXFWK2o4VkI3?=
 =?utf-8?B?UmhVaURkdXdsazNLV0RKbFZvcktUZWdIaTlma3JRSjJGVkNwd0FTWkEzZlBx?=
 =?utf-8?B?L2RTZjNKWFQyUy9UWVN1SElQcmhqRWlieW1sMFJ0dC9Fd2U3TlVDdzJoYXBo?=
 =?utf-8?B?enhlajZiYUdFZk5LSnhXakd5TXlPYWhTN1NNWVhYOU9HS053bGE0TE5KbE5L?=
 =?utf-8?B?TWVyRWgzUkdobWc5aktoQmExd0pEWFM5c09CdDl5MXNTMjl0T0I4TStYcUVo?=
 =?utf-8?B?dmRZR2IvejNLVGhGUStDWEMrdFkvRnc1SmFLN0VqZm5ENXpPckFpTVpNZnNo?=
 =?utf-8?B?b1JtQUlBSlM3dSt2SEMzNWE0cVpOZ0VlNlJXS3JRQWtqM2hiNTN2SU55VSto?=
 =?utf-8?B?WlhCbWtMVDNtZVhwcFZBRVFIbDR6bWJDOVZnWGxBWW1KZFhZckY3ZkovWmRF?=
 =?utf-8?B?UTZZMGtzc3lHU3I3TkptSGU5dXovakdDdzBKYUdZeHAyZWNuT0x4YlJmbWFz?=
 =?utf-8?B?QU9oUHE4WHphZ2dSdFlCcUtFQVRPV3ZTQmRJT1k5NzBBaW1PblY3cGFpcWd4?=
 =?utf-8?B?L0FOMEZpMHZjUzFUMUUzQnBuQjl2L213dENtU0VpS0NJa0lRV0l4QnNOM3B0?=
 =?utf-8?B?eUxjL0xlTmlQRGNMbk0vVkhkVmVQVDVFTTNEMmRDLzlZSE5DQmR1cWoyYXcv?=
 =?utf-8?B?cTVGQjFxZG1waWJCWjE3WmN6VUJYWDFsZ0lwTHVYdTk0OHpwV2R1TTQ0dHk1?=
 =?utf-8?B?V1pCVjdjVGJ5Q1FJSW1KMmlYdVNjVmtnYXE3bXhvZGpOWEZHY3hDcUxnVDgz?=
 =?utf-8?B?Q3RjT0JNSTZPVnI1NjVCZnZZS1JsVlM4Y3pLdWRKU21Ud21ibERXZGpmd2My?=
 =?utf-8?B?SThyWXFJaENmZjc1bmFzOWo3M3JNbFE2WEJuaVUreTFWc0tvUEp3TitZRWFP?=
 =?utf-8?B?RTQvNnZiSTlOWWphMzVFN09RaFluajQxVmNUZzVsQkxhVGl3RDNZd3ZKTTVp?=
 =?utf-8?B?eHM3QkcwaWg5VVhLeHYybXlHemdIR3NBMG9KRCtDb2c4VndmTFByMVA2T3hm?=
 =?utf-8?B?Zll0L2NNMysxWEVTdFF2ZERKcURwVzhZVHB2WG1jaDVvMDkrbVZKdTFubUpO?=
 =?utf-8?B?K1hnUVUvMFJYMUpZNmZoRnJSZnVrb0N1MDNzMGVMeXVhcWpwcEpqQ2JFOWNl?=
 =?utf-8?B?ZnhLOHY5cklaKzJBUlVWR0RjL2pHeXNMRDhzbHZzaUdkcTdWMGVvMUx3dVBG?=
 =?utf-8?B?eGplSXU3dUtzR05mRStyTGZ0cXEySk9NRCtDeGg1bWh1Vk5wN1NDSThPdjFw?=
 =?utf-8?B?Qjh2NFhCU0xWRGg0YVQ0aERsRzl3TllFRTVCNkpyRlp0a3o0WVByY3dBK1Vu?=
 =?utf-8?B?WTh4dlhYa3dSVWxUWUpzbjFnbnZEYnNFNWdWVUU1eUc2ckpUQllTMlMxT1Qy?=
 =?utf-8?B?MnhLVkRvcS9kbjlkZ1lodE1SYVliVTFCZnFja0NucWRFZGQ5OXNBdnFXbEFG?=
 =?utf-8?B?TEFKSXplYWJFU1ZTcFQ1blJBY0tPTEVheTEvVnhTRXZneFNTU0JvVXZidWhn?=
 =?utf-8?B?d2RSd0lQdDRCaDdFZS9VbXRueEZTVmdtZGF3dVBwREJ0a3FSQ1JDUS9aQkFU?=
 =?utf-8?B?ZnR1NE90Vk96Y1FQaGdHVW1xOGE4MkJKMWpaL3UvdVVuaGZjcEMvTURiYnE2?=
 =?utf-8?B?VkZXQ1Rza2FjaWM2bEwrK0xIdlZXTzhSQ2FxK21wa2NHb0x0d3I5UFZWTVlO?=
 =?utf-8?B?aElsSDZOMFh3YWNpU3NRN0J4dTRpNEJuZ2FRaTQvYkNoZlpqQjNucVozNFc3?=
 =?utf-8?B?eEx6dHhsZGZXME9hOUYwUmllTUpBMTlkWkpkQ3Fud0MzZmw1U3FRRFR5WU9T?=
 =?utf-8?B?K2JhU1dETXl6TWlDYjd4UjRSOUpCK2ZrRUhzNS9YL0ovMzNwdXNERG9zRW1w?=
 =?utf-8?B?dE1YakV4VUpkRW4xaFIvc1dMbnNaNW45ZVowK1daRHdFM2NQZ2tkWVh1Q2lB?=
 =?utf-8?B?RW1KcTV2SEpuRjlMWjdwejZuY2FNZXRNSU1IbVpqR2RVZEpHb214VzM2ZHd4?=
 =?utf-8?B?Q1ZpOHhsVnRWTUc0UWlGMUFhWG1nWUFSQjlCYzRrajE2Uy9nNFFSNnI1T3dn?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7F5E853A21E67438B74F361B8CCFAFF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HGk8rP/IGoIle4CjtnqkhsG62tWxzYEU41wqA7QkX4rvokAB6SHjHGfAT8Fz9gFQuG89RmJleMpeKvLzv45EUxom8AblCK5YVi6T3L7gd8sYFLimrHPgamYNs77yx3M83XcRx4e7v6Z82Ro2jX44pMSKBteIYuItMTxBMnV/QXQ4Dei/uUZpf0FopxThn451zAU2ldUUcXttW1LKG3ihZgJB7pnl+B5otGXltqug4B6my9RHBBvLvQgyEHVdzENjFLX7RBFzuZ1iExnscaZaiBGN8bK/f3hOVcoG5Eyy1vowLqWjROioiWQNFIka4QbBPss2RPak7lFT6PY59ZXphlg1zsQiCfVkHloQ2itvn+3D1crZ7IqgX5A3kPCAFtmzYKgEtHWO+eqw8F+QakVc1HErbxmc0JkE7kWq7cIS+nrQ5mLAVCm+av4Vh9z3KlS1d1eS/BLBzeuNVDqAFksvlFrYei9NIWQ2qmYaLw0Kuarg2dXgXdri4rKx7ZKgSRePxLOgfayaD4AeUjAohlgqUjAQJcXjAW8Po82bo7KZH1nUpFL43yGxY0fwPMKFcEJAr2/0WJ5484IJ6oGX5asqpDjXmCLDeltobEEkRgfN/2dZZyXrbyYDakja7WjC8bYhGScRNf80CiV9MMFVHCFSmenwiaVtJSKreXk6+vBiJ329bf0ga8s+XPYhiZ84aMJe08o6jzAkXpDjVo10XX2lc2PxI+gpBlQuUUPWoanpvuJnJVx8xFpmytR18uiUBvyowA8Tj/krZJ/Cj3GCRDirG9AD0qqY+z8/fYH97JRzrTBvUh964zEudvFo+vsXazxg0AYDSJyiC4PxoOd5JGWa/fDK5hlHwC+RY0JMfps7SZ00YjQssidozyE7cEZBwfBJNacf54XtjZt++YSO5YlhEwc7suiTvBNBWaOqpJ88TSs=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2437b65a-4000-4327-cb7e-08dbcb4de0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 18:05:54.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysePKtxGEaw7cXSSuE0/G7lVvmxGuG777m+tJ8840S5T8F1BtqnSNeVWAbnghVG7kghwFyuHy7RMH2gkfLKBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
X-Proofpoint-GUID: F6PbqzlbBU9vUr9uLRZ6bHRTnrWZsFd_
X-Proofpoint-ORIG-GUID: F6PbqzlbBU9vUr9uLRZ6bHRTnrWZsFd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMDUsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gQWRkIGEgcmVzZXQt
Y29udHJvbGxlciBmb3Igc3VwcG9ydGluZyBYaWxpbnggdmVyc2FsIHBsYXRmb3Jtcy4gVG8gcmVz
ZXQNCj4gdGhlIFVTQiBjb250cm9sbGVyLCBnZXQgdGhlIHJlc2V0IElEIGZyb20gZGV2aWNlLXRy
ZWUgYW5kIHVzaW5nIElEIHRyaWdnZXINCj4gdGhlIHJlc2V0LCB3aXRoIHRoZSBhc3NlcnQgYW5k
IGRlYXNzZXJ0IHJlc2V0IGNvbnRyb2xsZXIgQVBJcyBmb3IgVVNCDQo+IGNvbnRyb2xsZXIgaW5p
dGlhbGl6YXRpb24uIERlbGF5IG9mIG1pY3Jvc2Vjb25kcyBpcyBhZGRlZCBpbiBiZXR3ZWVuIGFz
c2VydA0KPiBhbmQgZGVhc3NlcnQgdG8gbWVldCB0aGUgc2V0dXAgYW5kIGhvbGQgdGhlIHRpbWUg
cmVxdWlyZW1lbnQgb2YgdGhlIHJlc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGl5dXNoIE1l
aHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3
YzMteGlsaW54LmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5j
DQo+IGluZGV4IDE5MzA3ZDI0ZjNhMC4uZDA3ODBiZjIzMWZiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXhpbGlueC5jDQo+IEBAIC0zMiw5ICszMiw2IEBADQo+ICAjZGVmaW5lIFhMTlhfVVNCX1RSQUZG
SUNfUk9VVEVfQ09ORklHCQkweDAwNUMNCj4gICNkZWZpbmUgWExOWF9VU0JfVFJBRkZJQ19ST1VU
RV9GUEQJCTB4MQ0KPiAgDQo+IC0vKiBWZXJzYWwgVVNCIFJlc2V0IElEICovDQo+IC0jZGVmaW5l
IFZFUlNBTF9VU0JfUkVTRVRfSUQJCQkweEMxMDQwMzYNCj4gLQ0KPiAgI2RlZmluZSBYTE5YX1VT
Ql9GUERfUElQRV9DTEsJCQkweDdjDQo+ICAjZGVmaW5lIFBJUEVfQ0xLX0RFU0VMRUNUCQkJMQ0K
PiAgI2RlZmluZSBQSVBFX0NMS19TRUxFQ1QJCQkJMA0KPiBAQCAtNzIsMjAgKzY5LDI2IEBAIHN0
YXRpYyB2b2lkIGR3YzNfeGxueF9tYXNrX3BoeV9yc3Qoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9k
YXRhLCBib29sIG1hc2spDQo+ICBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3ZlcnNhbChzdHJ1
Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9
IHByaXZfZGF0YS0+ZGV2Ow0KPiArCXN0cnVjdCByZXNldF9jb250cm9sCSpjcnN0Ow0KPiAgCWlu
dAkJCXJldDsNCj4gIA0KPiArCWNyc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X2V4Y2x1c2l2
ZShkZXYsIE5VTEwpOw0KPiArCWlmIChJU19FUlIoY3JzdCkpDQo+ICsJCXJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgUFRSX0VSUihjcnN0KSwgImZhaWxlZCB0byBnZXQgcmVzZXQgc2lnbmFsXG4i
KTsNCj4gKw0KPiAgCWR3YzNfeGxueF9tYXNrX3BoeV9yc3QocHJpdl9kYXRhLCBmYWxzZSk7DQo+
ICANCj4gIAkvKiBBc3NlcnQgYW5kIERlLWFzc2VydCByZXNldCAqLw0KPiAtCXJldCA9IHp5bnFt
cF9wbV9yZXNldF9hc3NlcnQoVkVSU0FMX1VTQl9SRVNFVF9JRCwNCj4gLQkJCQkgICAgIFBNX1JF
U0VUX0FDVElPTl9BU1NFUlQpOw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGNyc3Qp
Ow0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWls
ZWQgdG8gYXNzZXJ0IFJlc2V0XG4iKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4g
LQlyZXQgPSB6eW5xbXBfcG1fcmVzZXRfYXNzZXJ0KFZFUlNBTF9VU0JfUkVTRVRfSUQsDQo+IC0J
CQkJICAgICBQTV9SRVNFVF9BQ1RJT05fUkVMRUFTRSk7DQo+ICsJLyogcmVzZXQgaG9sZCB0aW1l
ICovDQo+ICsJdXNsZWVwX3JhbmdlKDUsIDEwKTsNCg0KV2FzIHRoaXMgZGVsYXkgbmVlZGVkIGJl
Zm9yZT8gSWYgc28sIGlzIHRoaXMgYSBmaXggcGF0Y2g/DQoNCj4gKw0KPiArCXJldCA9IHJlc2V0
X2NvbnRyb2xfZGVhc3NlcnQoY3JzdCk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBEZS1hc3NlcnQgUmVzZXRcbiIpOw0KPiAgCQly
ZXR1cm4gcmV0Ow0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpCUiwNClRoaW5o
