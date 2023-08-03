Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C176DBF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjHCAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjHCAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:05:18 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179483AAC;
        Wed,  2 Aug 2023 17:04:59 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372Jk9W6020665;
        Wed, 2 Aug 2023 17:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MHDHyXs+PDfpNsp1qwT7kTcuxcvGGnZG/s1ludO76Mk=;
 b=l69xMLgyI0yTZ7Z16qQUsC9HCnlXJFFbKSKDF6yEERTZthGb/fKuVhnEs2kqIpqgVM6u
 4T+CCg06SuoyOP75lDautl81QHcvSr+jsFRo5klLAyGIBjYeLC97F0TlS+FnsByFKUR/
 +soNoqkJS9/cBf8qUFdmpyjxQHp4kzOK2upCfzGJtcsvDNIGrKqJXrpaP86Y9F6b7K/8
 zvVFVgU33x5sFnrx7CIcZpgPKmxLKzHDKWKX1zoODA1f3rFlEndFTP2u/NAcA2PmhYMT
 hVZhiJjqKMjnewB7hPRpxPVXa0QB2wQ6UbAdoMZCIf2LHfXCUdvRHealmg+no9FjmcyN +Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51sq3rc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 17:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691021075; bh=MHDHyXs+PDfpNsp1qwT7kTcuxcvGGnZG/s1ludO76Mk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HfyiANZNCSjsC4m4htEi37MKabRBgWkkTZThcaoadS1zebBZZI0XLiRSHOlm886eq
         wywjFbdDpt2/fWZE+B9TrAEAAw5ftdMMbgu+93zF12knjDXIEoAws56LYqetf+hywu
         wo9+JDXyHka5aMAmKvXMDddfJ/zbtPMGWv+J8xJcrPjepCtEaneVzxndhPRjIeKSdf
         QvuFJYiqGVvlQX7qH5eN+oNUqbBSGl4FP6z/5hP4Mtpfg7DWml9Rf5PeL8LqEe/eiZ
         kpbPeR6wKkVtyaIjOcB6xHv6xuQ+oe+tFcb1r4tpjvl0biytpP+PYl7x1nLjtuuoZl
         4j13bqDdMggcg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86D3340564;
        Thu,  3 Aug 2023 00:04:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 24BEAA008A;
        Thu,  3 Aug 2023 00:04:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eIsFE7uc;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DED6240132;
        Thu,  3 Aug 2023 00:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efOwqsYqPnRUzAX+63zWNU4VgusADUlGItb6dWfKo/fWP7Aa1rmhjso5Sv5p2d0W996yoi1tDBCz8ulT5KT+pBO3Bs7VtTTTouxP/Cs3YSpNgqvCnSMXbmeZDpz37QZploFP+WgU128p03m29M+JcOeczY4F6UAe9Dryu3GqJw4CQIlLwomXawf0yixWEQaUr5+PbelEa6U4eQlMnEYL6KCNwssY27JKxWX5xdjVJUZ1EPGk46QcF1q27GVyrEr6RMMkxENwzwLg6u/GSv6EbkRDpeix4jGZbNLlOGlwWF3VyO3+eO+7JMXcqCnw28KKPOvMkMS6X+bsDLg964O7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHDHyXs+PDfpNsp1qwT7kTcuxcvGGnZG/s1ludO76Mk=;
 b=V9Nlf/HwwpLlZ8F1yL486mu2L+uyI33+1QG7dYavRqTI3mMYYyd1zOKf+Azfer8oK5yqdi8gK/QU9pMoViGEr+TqHR1rW6fTfG6X3nsUl1dp/m0MArZUsKuUjx9hnw9IfpG395SChlzrEXz8LtK++7olzZMQ2uG+G+TLnyDRRVfJQBwYX3koJQEHmMSwhEH98LyV7DYqQZh8Js0PE2IdQRhkaMiGq32ga9IMGA4SQi9FoeAMp03EIlwFwrlnmadfuSLo3j6SBBEAySyMTGog0ny37nFtbCQ/hi4/ocYhQ51uacesOVb8KMYf9sD6yC1Dr7OiAkPESq6g5XwMbJvuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHDHyXs+PDfpNsp1qwT7kTcuxcvGGnZG/s1ludO76Mk=;
 b=eIsFE7ucubuAAAIRTW2hvX/GNW+FDOUjUvq9E84ClZe4RW2fV0w6UqdAJSRezBpfXS9AaZuTJ3+ErYXcnvFsDHtyhW02+4pq6ntdYxiPbXDOuD1dGMFaF86OPEqDfAuljoKjV4c2BX/lF4f7pEP4TbeYod7EStUG5Av9fKqwBbM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 00:04:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 00:04:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer
 driver
Thread-Topic: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZxFow++w3UXyhskGxvNTqsfGMb6/WNIgAgAB47gCAAQXsgA==
Date:   Thu, 3 Aug 2023 00:04:27 +0000
Message-ID: <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
In-Reply-To: <ff9ca6f15936450696bff502c0047708@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB8324:EE_
x-ms-office365-filtering-correlation-id: fb6d30d7-29a1-41dd-30cc-08db93b5341b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1KwMqtGaYGMLNI6BKYnHANnSyjXmi+FLXukZwIEWMAXC+siu6Pv5OpZlUE7dvRxCvmIsWyiePK/G726EeBC3TXUqEn+cR7bykuymiuEJHLtBbyB/ZhHjcMoetfdR4a3LoYHbArdx40jq0iueUsfqOG6ddtl7XUc4ClJ7qTaoFjqdwaT/Cg1HS5N2GWrsjj/Wp1+u/1O+8pb2A67JWzvPc5sD1uMVsgD6pJAdEiK/CvYTlyUe9fWhfjzPnFngIU9akBxGbaMh/aJqXmkWgidMKQNWikU9NaeZtdszXJiLOvmNlbDL4m81SrzLnm7fqAhOnvJN4ujGsM/xSHa8qL0mVax6yBTIpFp2XjpGGCFh0u/II7jt7yIZM7IhGYOvvIuc59mYuVw25/jptDRz7Urh6Izc+7SIrhzACsLLeYEX5D2FUJOOsULz6Xsqmo1dvEjYTecTpg6th7qm1Ejp3vMdbiwuPKscMh7qdcN983Nk69/ABflT0PmP1mKWWBt6wCvfj5HS1PvdLoJWcHMohY19JFWTdFfXXSjhxfgdX0dSmOWjVdLkXyx0N5Cd56hfPGVxak15Eaar7VpEK6+KI9MUtKivxFJC/fc5Kvkiwjtj7/9icMf4QrBPS4Kq1CGn50l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(2616005)(6506007)(1076003)(26005)(186003)(316002)(76116006)(2906002)(66946007)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6486002)(71200400001)(6512007)(478600001)(54906003)(38100700002)(122000001)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNlMDNBWFBBT0pUUnZxYWc4MlBLT09TZzYzSi82ZTJDVUlNSGJMU1RYNjlx?=
 =?utf-8?B?cjRscWFMRmxSMnpNaVFRNzB4bE9IQVBDRVNieG5Ra1pwVTZMT2JHWXpUSXdE?=
 =?utf-8?B?eHhZRzlHWVhOY1NiSTBJUjBielJxN2pld2UxSW5WbEdCbTg5RWxuUGF6c043?=
 =?utf-8?B?R3ZYYW9UR2hyTTl0SDZENEZIZFZscmhBM2VkNmlXWnFrS3gzZXdHRS9yK2w2?=
 =?utf-8?B?YStpcUhrd1RTb0k0UHgwd1hwVnEzZEd6amp0cW4vRXQvVGVVbVRzV1p0dlZy?=
 =?utf-8?B?Z25ZdGpwK1JFZFFwUC9lSURWbEVvU1BadGhVM1dTTVJrM1lRanBoaWFaOEJX?=
 =?utf-8?B?WXJ4VjYyZi8zZkVJNHlycThNVFZSVHdqOVhTUjNLanI4aDJWODY0ckNNVGhm?=
 =?utf-8?B?THcyM1VkdUxqQnYxRThPTDRsR0dPZ01wQWN2NE5mUjNHalo4YXpOeGdqY2Ny?=
 =?utf-8?B?NjdJRndUNXJYOHR2ZmJBbm0rZXdjMW5aOXQ3RnFWNktva3ozbnJJa0pLdUhw?=
 =?utf-8?B?OEp0L1FiSk1kYkJNZ1h5aEtKZUVSNzFDUmVsNVpnSDdwcHFXNGtFZytLTS9R?=
 =?utf-8?B?bnkvd0w0ZzU5MUltNVIrMWxqVzQvMEZXNTAwelkzWWRuSm9JdHY1TlJTZ1pn?=
 =?utf-8?B?Z2Q1Q2J3bnh1VFVFK3YxLytOSFFUMnZocExwVmNuSWtRY2V5L0F1REs4SVov?=
 =?utf-8?B?aHRmZUhBL0F2MnlVNEJ1T1JyUUNWQkR2ZFJtL05VemZTb0gxS3pMMmlTblp5?=
 =?utf-8?B?ajdoenZFRkthZGNFeWpDZXIyOUMwajd5VUgzaDBhMkRhVVowWEJPdWUvN0RC?=
 =?utf-8?B?NWlDNjVJVld0WXZhTTJJNjRQdlg4a2pjbVBIYWMwSkR2TUJJNmttSERPZTN4?=
 =?utf-8?B?anoybkRVSW5NUmJvSExuQk5IaVFPOFJzWFUwOWVWZENURHVCR0R0VzV5OWhj?=
 =?utf-8?B?UTV3YnJyZVdEdklGNitLNEhjbUJ2ZXlBWW53bEFvVHFrY0lvZkd0c2dhWGcv?=
 =?utf-8?B?NmdCbHhtS0xsSlhsS2EzQSsrSjM3MkFwTW80bnF0c1JUL3Z2QVh4RGJLUDJY?=
 =?utf-8?B?UHJWRGF3TFVZbSttMkZOU0lXNXFwUndFMVQ1T1JONHVsMjhCdWJ2bk5wMHg5?=
 =?utf-8?B?YnMvZTJ4TUR0SWFjcXVhSkkydWhYL3pKd2RoNjNaajBzM1dVUUZ4UjJnNlN6?=
 =?utf-8?B?SVg0TlFja25GeGYxTjlZSUtQa2N2RWU3MWJ4ZkFkTFZBcVpMcm82eXNoVldL?=
 =?utf-8?B?VkxocG9uejJaREl0cXp4Q25xNzluT0VOMWZudjN5eXNnYVhjS2NzVHNkTmNG?=
 =?utf-8?B?emVDcHkzUEx1MlBaNXBEMTJPbDNNWmxybUZHcUxBNXp3WHR0M3U5blVKaVdX?=
 =?utf-8?B?NldrTFA0cWhoZUd1UHBLb00vMncrTk5HNnFEK0NMcmc1WDlaMk9lcENkT1hj?=
 =?utf-8?B?ZkRhUUxEL3B3ODd3VVVaRWpvUEdRay8rVWtzOTVYTXlqZTFjaXhPSTZjaUxP?=
 =?utf-8?B?cHdramo2OVQ4blFQVDJ5U2puQisvOFNySElSNzZBU1JNVk1iOTNqZCtTUm5Q?=
 =?utf-8?B?Y3hsYURrS3h1SUg3bkF0NjJvQUg4MUlnZlhwTnZncnVUQXFJYkFSUVNRNk9t?=
 =?utf-8?B?K3lUN0lDUW0xWmZoekQrSzVqU3BiRUg3dXF1NGdpUFRSRkFSb3QvOEJ4U0xl?=
 =?utf-8?B?WUxuUjVvY0o4K3kwUlF6Tkd6RlpOSG9yYndCQ2RIMEpyT1FTWjZ2MndYZ0t0?=
 =?utf-8?B?TjlFSWlod0s1cUJ1aTZSbmJFeWxuK0RrbTQ5ZWlBLzZqMjdyTmxMVnJzYi9D?=
 =?utf-8?B?d2dSbE9lMHE1Smk2T3JQYmJhN3RzSUFETklmbVJFbnNWMVdHNmNlc0diU2tu?=
 =?utf-8?B?SXJSaHNpMkRXUVpLSWl3c2FWTGNJV0NDYkdrdzJ3SXNuYkJPM3FMSnV4OEpn?=
 =?utf-8?B?eEg1ODNla2UzdllrZTdhMmdvL3hqUHVOT3dDNEN0VGxIcVNFUENCOERMbGZm?=
 =?utf-8?B?TGY2QkVSbXlGREZZYlhHS1BpRU9ZKzF4U3g4dU8xR1Nnci85aFNrRExnalE0?=
 =?utf-8?B?MmU2ejVISG1MaUlRYnZKc3hGTmt3VHlrUHBqa3RVdHU2STJDNHNLU2hKQUdm?=
 =?utf-8?Q?EDXwVydmUjbSTLF2+giXCfWjD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <003048C13134C743AE92342CF464CEE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MWZoa3AzT2cwSEk3dU5GenRQRWVCYkd4dmVmYW0zVkhJcHhGRi9aUFhhUmc3?=
 =?utf-8?B?L3FZMlltUXBqR2Q0eVR4NFdqNHVPTHFLaUc3WS9laGJMU29XZTZ6MTdiTlZ0?=
 =?utf-8?B?VG52VUY4TmlybDlmU09YNnNDYXY4WXF0ajhWbUEwOVBZQkVCQlhiL2xBb2E0?=
 =?utf-8?B?N2N5V2J2dDhBTzlnK1E0bUpZMUtlaFJ5TmVTdDMyYS9xNWJKRjNkOHhwQWtl?=
 =?utf-8?B?aUl5K2JXUlQ0by9pMXd3bURkUjBOQURZRmRxcSt1aWN2dVJmTXJEWEk2MnRj?=
 =?utf-8?B?cHlVYnY2Y3Y3SmJqS0xJekRLbkJHQkJpbWxqVWxiditZRGdoaTRidmdwOUky?=
 =?utf-8?B?Rys2d3pjTVlBQjEzR0J4RWYwTnpOYXk4eDJEb0FJZmVxVDNYVlF5MDFMLzJm?=
 =?utf-8?B?b1B5NVBNV1RScm9KbDdpOTVNUFg4ZVBpQWlxQVFQUS9HYnBRRkQvS0VWRFo0?=
 =?utf-8?B?S3VrTU9UM2I3Q09xMEJIQ0QySUZ4NmJPclVIY3FiOVI5cldRMHhXSmdnci9M?=
 =?utf-8?B?Y2Ivc0NkbnU5NzJxQzRrNkZaWGsyT1QxUTNpdHk3cnV5RUdyYVljSG03Zm1J?=
 =?utf-8?B?UEFhZkhaeDJ6Y1c5R0NHZTdwS3ZxUi9zaUJYOGFXUFZiNTRyZjJheHJIeWdw?=
 =?utf-8?B?QUpzdk9iSlhGaFdsUkJPcVFqekZnS1RlVXFnOXVQakZ1WHNFM0dRODZPWHpl?=
 =?utf-8?B?U3ZVVHRoemc1R0Y2UWdweXYxcjFMSjRuem9BelpOMXo3T0prVTJjWmpsNUZm?=
 =?utf-8?B?NjNvNTNaZEI4TU1rWDFPMy85MTN6dVNXZ2IrUEdDTFRncUlNYlV1dmpZSGJR?=
 =?utf-8?B?YWdNTlBlcUFaRitybnYwWVpqK054bXJjYlJwTWl4T3k5YUFUYXJkSzc0M2dY?=
 =?utf-8?B?elRPNkJZU0owK3lEYUhrb1Z5THcrK3pQZHEwRTcvcVZIeEdyc3o1OGxrVWFD?=
 =?utf-8?B?WElMRis3K3JuelFMWStKNDlzMWE0ZzY2UnlNNDBnN0xiL0l2Mkt0TURtVjcw?=
 =?utf-8?B?Zzl6SmtpUTFMQ003YmQ5a0ZiTXI5cTUyeGE5Q2Vuemh5NHQ0dzZhVVhCajB1?=
 =?utf-8?B?NzZMbDlqUUoxSGlVMzkwbElHSVpyVTlndWtSVUxQNWFEOWZVMXNXbUNRaGFF?=
 =?utf-8?B?Q3pIL3FydDlEbW5XUWJzS2JJbWx3MXlCQTRjdFhBZTdwdklsTWFqOExsWVBC?=
 =?utf-8?B?SHZYZk1LWTFLUURTNzM2S1lPbWk3K2lWK1RnNjdENHo0aCt3cDc3WUs0WGdD?=
 =?utf-8?Q?BtfqjRg4mVRDvUc?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d30d7-29a1-41dd-30cc-08db93b5341b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 00:04:27.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6zAvJuGWXNcLBF4bF33BLHGo2xT4PTvN5tPnTyiTKYeVCBGrdsbevodzvUXQ9Bt4tXVU10Ys/D19An8B4fjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
X-Proofpoint-ORIG-GUID: bnddQQzxY24ZzRzkRX7a6_52xpk5hzP-
X-Proofpoint-GUID: bnddQQzxY24ZzRzkRX7a6_52xpk5hzP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMDIsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
DQo+ID4gPiArc3RhdGljIGludCBkd2MzX3J0a19zZXR1cF9yb2xlX3N3aXRjaChzdHJ1Y3QgZHdj
M19ydGsgKnJ0aykNCj4gPiANCj4gPiBBbnkgcmVhc29uIHdoeSB3ZSdyZSBkb2luZyB0aGUgcm9s
ZSBzd2l0Y2ggaGVyZSBhbmQgbm90IHdoYXQncyBpbXBsZW1lbnRlZA0KPiA+IGZyb20gdGhlIGNv
cmU/DQo+ID4gDQo+IEJlY2F1c2Ugd2UgaGF2ZSB0byBzZXQgdGhlIHVzYiAyLjAgcGh5IG1vZGUg
dGhyb3VnaCBzd2l0Y2hfdXNiMl9kcl9tb2RlIGluIHRoZSBmdW5jdGlvbiBkd2MzX3J0a19zZXRf
ZHJfbW9kZS4NCj4gSW4gZmFjdCwgc3dpdGNoX2R3YzNfZHJfbW9kZSB3aWxsIHVzZSB0aGUgcm9s
ZSBzd2l0Y2hpbmcgaW1wbGVtZW50ZWQgYnkgY29yZS4NCj4gDQoNCkkgZG9uJ3QgdGhpbmsgdGhp
cyBpcyBhIGdvb2Qgd2F5IHRvIGdvIGFib3V0IGl0LiBEbyB5b3UgKHRoZSBnbHVlDQpkcml2ZXIp
IGNyZWF0ZSBhIHJvbGUgc3dpdGNoIHN0cnVjdHVyZSBhbmQgcmVnaXN0ZXIgdG8gdGhlIHNhbWUg
cm9sZQ0Kc3dpdGNoIGRldmljZSB0aGF0IHRoZSBkd2MzIGNvcmUgd291bGQgcmVnaXN0ZXIgbGF0
ZXI/IEkgZGlkIG5vdCBleHBlY3QNCnRoYXQgdG8gd29yayBhdCBhbGwuDQoNCkhvdyBhYm91dCB3
ZSBjcmVhdGUgYSBjb3VwbGUgb3BzIGNhbGxiYWNrcyB0byBkd2MzIHN0cnVjdHVyZS4gT25lIHRv
DQppbml0aWFsaXplIGdhZGdldCBhbmQgdGhlIG90aGVyIGZvciBob3N0LiBTaG91bGQgYW55IHBs
YXRmb3JtIHNwZWNpZmljDQpkZXZpY2UgbmVlZCBzb21lIGludGlhbGl6YXRpb24gYmVmb3JlIGlu
aXRpYWxpemluZyB0aGUgc3BlY2lmaWMgcm9sZSwgd2UNCmNhbiBpbnZva2UgdGhlc2UgY2FsbGJh
Y2tzLg0KDQplLmcuOg0KDQpzdHJ1Y3QgZHdjM19nbHVlX29wcyB7DQoJaW50ICgqaW5pdF9nYWRn
ZXQpKHN0cnVjdCBkd2MzICpkd2MpOw0KCWludCAoKmluaXRfaG9zdCkoc3RydWN0IGR3YzMgKmR3
Yyk7DQp9DQoNCnN0cnVjdCBkd2MzIHsNCgkuLg0KCWNvbnN0IHN0cnVjdCBkd2MzX2dsdWVfb3Bz
CSpvcHM7DQp9DQoNCg0Kc3RhdGljIGludCBkd2MzX2dsdWVfaW5pdF9nYWRnZXQoc3RydWN0IGR3
YzMgKmR3YykNCnsNCglpZiAoIWR3Yy0+b3BzLT5pbml0X2dhZGdldCkNCgkJcmV0dXJuIDA7DQoN
CglyZXR1cm4gZHdjLT5vcHMtPmluaXRfZ2FkZ2V0KGR3Yyk7DQp9DQoNCnN0YXRpYyBpbnQgZHdj
M19nbHVlX2luaXRfaG9zdChzdHJ1Y3QgZHdjMyAqZHdjKQ0Kew0KCWlmICghZHdjLT5vcHMtPmlu
aXRfaG9zdCkNCgkJcmV0dXJuIDA7DQoNCglyZXR1cm4gZHdjLT5vcHMtPmluaXRfaG9zdChkd2Mp
Ow0KfQ0KDQoNCllvdXIgZ2x1ZSBkcml2ZXIgd291bGQgaW1wbGVtZW50IHRoZXNlIGNhbGxiYWNr
cy4gSW4gZHdjM19nYWRnZXRfaW5pdCgpDQphbmQgZHdjM19ob3N0X2luaXQoKSwgd2UgY2FuIGNh
bGwgdGhlc2UgY2FsbGJhY2tzIGF0IHN0YXJ0LiBJIGFkbWl0IHRoYXQNCnRoaXMgbWF5IG5vdCBi
ZSB0aGUgZ3JlYXRlc3Qgc29sdXRpb24gc2luY2UgaXQgd291bGQgcmVxdWlyZSB0aGUgZ2x1ZQ0K
ZHJpdmVyIHRvIGFsbG9jIGFuZCByZWdpc3RlciBhIGR3YzMgcGxhdGZvcm0gZGV2aWNlLiBCdXQg
SSB0aGluayBzaG91bGQNCmJlIG9rLiBJZiBhbnlvbmUgZWxzZSBjYW4gY2hpbWUgaW4gZm9yIG1v
cmUgaWRlYSwgaXQnZCBiZSBncmVhdC4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
