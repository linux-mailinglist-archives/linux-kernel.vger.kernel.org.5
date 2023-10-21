Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D57D19FF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjJUAkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJUAke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:40:34 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA49E8;
        Fri, 20 Oct 2023 17:40:28 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L0e2Qe020322;
        Fri, 20 Oct 2023 17:40:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JHnVkIx6Pg3JvVgkceXDpBA2XAA8/2pg9wYa+KeWfOg=;
 b=a4RxLsbflWeidW3Em1c31Zd9y4fpZBnYhlmctZva/tm4PXZrf1+M6dYThrm/QQrYeJ/g
 ZWf+3BWw4/QM7CH3BfH6pBvVci/RnqLs3E6Dqqi9O6dPxzUpwY9ibxy457ds5YqurqtC
 gnMVuSE8aqI5SDDfYONXx8HGPnsMsP+MeNs9Gnbw4u0jXX2bqf9bWeA3WNTXzS+pywrl
 io1XQKzObpFE5ZuKFSvKXiBj1Iz4LdQpiaWPsZwPZe/zYzD2vrJ8EuDdzpKm8IUlDV+s
 YPtPXhlSCGJdjSpD/yCyJ0CwmufchM/xZZPy7s4k3UCXOg4rFwX1dmbD+N1AwwFB977i /g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubw4v1qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 17:40:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697848809; bh=JHnVkIx6Pg3JvVgkceXDpBA2XAA8/2pg9wYa+KeWfOg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IulSagKjRIhDxZStBx8xKor/T9kOTGqADkadNAGMFmTq4JKA/wP/kOg1Std2wqcql
         6JkIlfhyXIstXCoCfosmCsZnHeHVi21Ibhx2O6PNzahLtOFUc8/ldDBYxm9fwOd6yf
         UffwcLH6++0UV3rjsXMDr2SMCTnUHatAynyU4Fu7KRcVq1QXX2Ru1hUnIBL28h+yyL
         6nqbSmytiFfpQlUZeKJzeSy1XEQGGWn1qWv0ntZBNIUBkWspfE+KGUEthb7UaegOCI
         UpG38WN4XfDq5EkOIW1VDoQ90gs0Ge7iJ0X7PUVX7wMR37+vsfl3+Fo35C3oWJ9PTR
         kehNjZOxuAhIQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2CF96401DC;
        Sat, 21 Oct 2023 00:40:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4F24EA00AE;
        Sat, 21 Oct 2023 00:40:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ofC7Sjli;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A356440121;
        Sat, 21 Oct 2023 00:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdS1Wws7AyuC5n2m0Bx2YqEzbubgm196N29fmSfLr21+pwVRlsQ5XliJLKaD+6PYNldU6+Q8baTodmzC+g4ZkLclKyUFFmntZxZATJyJBHjkKLL3oiroqwVL8DNIFWeehQqfKtESvEzNSJJ4jZSzxAnTz4FkNzHdXJQMFJLc8vnIhQIkIC6dUvMAOfOUkpWtWhsiA/guRfR3vqDlSlAJKsoJfTBC6z/nnAb760aF8LMhbIai5SxaO7icp4W/Bg9XGX0EBpShVA61ZYlSdodtnGLZD5M9aBNaLukSPEZnKobLERKS7rbRvGrcEcJCxh509woXvo/gZjtiCmgvSfzHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHnVkIx6Pg3JvVgkceXDpBA2XAA8/2pg9wYa+KeWfOg=;
 b=Hko88WMaWFPDPQh4hJRghb99QKZrLxlHFZC9eWulyVYVfDkGBFrqMRBEyS36/cdgeFUrhJfn9mSvePcXyTQMpeipzKzxIFBKa5orpxnp9SSmaIIWqE17i7b8XEf0ZstnFxVgziZRjhBOFqG3OjAjvu1loasJe4Xcyn8Plq6n//Z/W7Wnkl2XBAfJWlQqnMGvf326JC2GwxdkfQUtOzUhgbSWTVS/W0MBIc/41VGz6j3JetaiMS4ZbyhjJl1I98hx+Bls5oe422dC+6gOpwk9aVm1qyndS5FXmN+M33riRD/aIQ/S6hjX6CpRRn+R6SgYJBSEXJSmmtnSaAVEZARrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHnVkIx6Pg3JvVgkceXDpBA2XAA8/2pg9wYa+KeWfOg=;
 b=ofC7Sjli88wb6d/ZzJQt/fdOm8Mnwpj4tYJ66nvpVnJHPLpyFAVwJpPifjAlL5E0jEe0oy/to/Nx1SnbG4uaGaSwovY6oYoGd1w96ybN7gIVKnp0+VY4xz93UUwWtuzwALmoQQ+qWn69+c9W6q42JKs9/+NVGgAOskCTA+R3Xsc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 00:39:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Sat, 21 Oct 2023
 00:39:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v4 2/3] usb: dwc3: add optional PHY interface clocks
Thread-Topic: [PATCH v4 2/3] usb: dwc3: add optional PHY interface clocks
Thread-Index: AQHaA2YtgpNNExl+60CIagyLoI914LBTZ18A
Date:   Sat, 21 Oct 2023 00:39:55 +0000
Message-ID: <20231021003944.swkkhveyy4iwtyk5@synopsys.com>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
 <20231020150022.48725-3-sebastian.reichel@collabora.com>
In-Reply-To: <20231020150022.48725-3-sebastian.reichel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4391:EE_
x-ms-office365-filtering-correlation-id: 0f4b82ce-9942-476a-9655-08dbd1ce3f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SufCq3+oO/ShL2out7MnnmKZTka8WCBJAns5SCk67bkXT3SitxLcGq7khF1DINLtqEZMx9I7E5ZDEEUhXEPSdINWLCF1r3b+M9TJwV+Uyn3v4DRNPiwpQvRa3mV/X5diXxRniFy/wB+namS5QX3X5efpriEP8JTlYdioBXs1O/E7T3MNHtJm4FW3iYekHroYAwaWwONv3J1PHvIXMVbTR5O5bOe0CXCVTaA3f+T32Ak9Csbz3cnIbcTNG2BVhBQRrkCDq2yyxfXJj1P/96NoAOxUnlS5Z3awAUwBFMf+pCN+0tSS702w+mfXbSiegN7Uzr4O/0rxBqoQKu6E6KpGHuozkxwVnqqFen3ZhO/7/hYlVAUgsqpz95V5B4KYNM2TlKIxk3vNsDwE/Bc5IoORIWSIc8NQ4yxw8YeF6XCy6DDgGot5BZeJjxk4wwZ5wLIOndRtDRyRQoZkRgKR4EFXcM4cmlLBwZyJ7WY3Q4qcNDBjp3M5OV+3qdqQ8hSA26grj9mhDoyVpBzPKBCwGdDNGuA3PGdxMRe8bwO6Ruo4BgZEk3rbzeskR4klSUXAIZ2sCtEnvhGj4iZncv652nPIlkzxu7hBCRezppB1RmC04iSHJFlIr1maKIZKYv+x311j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(1076003)(38100700002)(2616005)(26005)(71200400001)(122000001)(8676002)(83380400001)(316002)(6916009)(64756008)(6486002)(4326008)(66476007)(66446008)(54906003)(66556008)(66946007)(478600001)(86362001)(36756003)(8936002)(41300700001)(6512007)(6506007)(2906002)(5660300002)(7416002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWRLdHpsdWExdWlNK2ZzczRocmtqOE4vMzc2dWw1VFg2blpja3ZrQ2RxNjBx?=
 =?utf-8?B?M3RLR05kcUlsK1hZdkc4MWFVR0NOOG5TK3pMOHNZRXlLN0hvT0JoQzhTT0JE?=
 =?utf-8?B?d1lXaUdieTdzYk5JbkM3d2JqOC9DTC9HTXBZeEdLSmN3RlRRUytEbXpPaU9N?=
 =?utf-8?B?K2tjb0ZSK0FuRitDSnpGMmR1a1BtRTNhemgrNjdWSTdLaS9lQXV2a1NoSDJu?=
 =?utf-8?B?U2t2bTl0NlRCYnprb3pyQ1liMkRwQmRKWWRxckZHZ21uUUYxMmRCYllQOVJK?=
 =?utf-8?B?bFF0eUN2RlU1K0dkTGtBZFl5a3hnTkpJQjcwTU91SjZ1VVhvMHloSXRxY2V1?=
 =?utf-8?B?NXhleUVDbDN6N0Q4TUk0Rjdxa2p6eUp3UFZkTXYyMXpyVnA3RDFWd2dmdTdY?=
 =?utf-8?B?NkI1b1BjSXJBRENzTWdHRGVFQzhGY3YzNFdWR0lCbXpiNlZUTnB5NG1zbGFj?=
 =?utf-8?B?dmZYRVJYamFzZVA4TytkbWkxQ0w3cjE2ZnJ1RjlKYmtEYjlDbHRxNlp1ZEUy?=
 =?utf-8?B?VlU2UktCU1lwZ0dLY2lMQnBTazczU2UraThtUHoxV25CZDRacHV3cHo1ZlBQ?=
 =?utf-8?B?STh2dzdRTm5SV0p3MXp1ZU9SRGlOREc0ZmZ3bzJjSnZobHp3azcyS3MvTTdv?=
 =?utf-8?B?VFVOVTM2WG0yYzN4RUZ5UnlWblNOZTIydHVISUIwTUVlRzEySmowV09tZ1VG?=
 =?utf-8?B?U2g5MjN0b1hXOXVtK2VFSC9uQzc0UzdZVTFrc3lEMXhDdVdFdUVKV2lMNDdm?=
 =?utf-8?B?RGtPNnlZQlE2c2lILzkwbktzRUxCeFovaUFhdXBkMWgwM3FFOWdIa1lycnFm?=
 =?utf-8?B?VXBCUUFBYmdUVUtmY0lSbCtqVm5SOXVKWE4xV2lHdXN5WjZyWVdDNitSemtB?=
 =?utf-8?B?d2hiSXZkTktDTTQxZHYxazBwakZKV1l6QWJocEhVblBIZXA5dDFXTnlsd0Fx?=
 =?utf-8?B?eHppVFpORGQ2NFl5WWhHZG5LR3N6RHRTVXNhWVVKWWF0WVpHeUVHbUhGK24z?=
 =?utf-8?B?akVtL0RubGZ5QUtoSldKQkpUZS83ZnU0a1pZcDR0WEVSSTVWeW5iSWcwRm9p?=
 =?utf-8?B?Z29PWTluSlJHTjI2c0JWQmhNS1JhTjY4Z1ZMNUFvam54UWUwRXIxbXNFZzZF?=
 =?utf-8?B?QnlneDgwa3AwdjF5VTZ5UC9HQmU3UUN5ZkRzL09meG1MRjdYR2QreU1jS3I3?=
 =?utf-8?B?ZEdKOHQrY0lUZi9jem5sN1VRdXJNODBMT2dFWUNlQW5aQVJlWHc1bFBMeUoy?=
 =?utf-8?B?MVA1b3E4bkxTR2lrVTdsN2tjR3RrWDRsVUM0REhHTklKYUUrU2dpWUpXUTdu?=
 =?utf-8?B?ZFRZQmF5Nmg2dmxDSzRlK2JreS9SRkhURTBiSTVvR1NZRWMvWVBWdzh6WDdi?=
 =?utf-8?B?Qkg5Ui9tRHdqOW1HNnRTdWlIYXJmK1k1SzJGdjJlVnB3WW8xbU5WVHVSZ3BW?=
 =?utf-8?B?RTV2blVuT0tuMkVUR0sxVkVKbjdsT2lacmo1R1ZvU2ZWbHBicUU0bnQwYW5z?=
 =?utf-8?B?MnVnKy9abUtrRFJicDB6WWFyUnozZmt4QnV0eGpYNzJwbm84QjI3MnM4MlJU?=
 =?utf-8?B?SHQ2b29ENXJFZVhrQXd6bmhURml2VTlJM0djYW5PdWtKSXFqLzdpMENWTTd2?=
 =?utf-8?B?OXlmcm1NTTg3RnBhNGVqbGdjWDF5NmtCQks3NXMya1ppL2dQQmMxUWtzTlRM?=
 =?utf-8?B?c1VrU3JLWitCY1lRU0NtYWRDNXpQSE51RlVlUE5KOCtkQ3NWQk1zVDRuNUJr?=
 =?utf-8?B?RXB5Unp4OVNjQ0NnZkJpNXduTm5CSXVUWXpyWnFrNkwzbkRrMUsvNHMvNTh5?=
 =?utf-8?B?QmVXMW5IZThOb1FoZWdOMFFERjRTeEd4OVB3SEEyZWViRWxYR2hKeVZnQmsr?=
 =?utf-8?B?cUs3R1hPV016TDhHaE9wOTBwVXdHTHRKcUJocG5kemp0QndXZ2J4enpwbFZw?=
 =?utf-8?B?UTgzS2NiN0UzTXZsVmJLOEEzSDFHallGWTFpV2gxV3dFZWdMSGEwVEZ4cU9V?=
 =?utf-8?B?R2wwRy9vdzJzUWhlNnNscmMrUjZhanNhVEl1dnc2bmplYmpwOThZTVlyc0JE?=
 =?utf-8?B?K0U4eWNXSUVCQ1NtZE0wbTd6K0hubGpsc24zWlM1SXNuWnUvbkw1d3N3Y2wz?=
 =?utf-8?B?OWM0a3VocGt4aUpEbWhoTktUSi9lck8rUC93SjFBTVZndUpkbGZOY0t2NVc0?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A642F42671ACD34DB190EA4276B3E095@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTJCS2JJYng4bzJld3YvUXpEa3c0bDJZZGZLZDAxR25LUWhlUHN4UWU0ZUor?=
 =?utf-8?B?TjRhWFQ4T2kveWtYdHFKOW0zWnNRUll0dmhuQjl4YmsyQnpLL2hkampvaDdr?=
 =?utf-8?B?c0JMMDlBZHI0WFNJOUJNMFRySXRSbzZ5OThUNFdaTHM5dFdGRVlIaHUrUWs1?=
 =?utf-8?B?dXZSKzA2ME4xclpUYlJlNGhDMXVHK2VRL0grbVJramtnQUd1S3RhS09KYjRu?=
 =?utf-8?B?U04rU1gxYXV1cDBFMktJQms0VFZKaVZjR2tyOVVYcFlxU2k3ZW5NMVF5bTlR?=
 =?utf-8?B?SjZrS0hObG5CVDFUU1RJU2NiRElZK1Yvd281bWlsM0FvN0J1bS9GRkpjWmxk?=
 =?utf-8?B?MXcwSDg4UW1oZm54VGhmaEk5aGh6Y1kxSW1oWDBaMGNVSWNDUDhvVFhGcjNR?=
 =?utf-8?B?R2ltelJLb0J1WFAvdzVYVWYvWG12cXAvaU0ydnovdW5nN0U2K0U0MmtKVHJT?=
 =?utf-8?B?a3ZWUHRzeXNGZEE1bFBtZHFEQzh1K1hObjg1aVVVa21Jdnd2SW9ISWFESVl0?=
 =?utf-8?B?OWgxRnlIeHNNbEZ4aGFVVElsaFk4U1gxZW81YmNzdnpES2NVL085d2VpdWVm?=
 =?utf-8?B?MVNaTkxjbnZIWVhjVGlraUViaHBsNDc5RG91SG43MStTS0R2SDkydVlDbGxT?=
 =?utf-8?B?c0xDNXcrbStwdnNtM01zU0JkekFDbzJ6eTl4NmJYc1ptcGxaZXhlbXNQUVZE?=
 =?utf-8?B?LzRFekQzTW5zL2FTdk1JOVBONkpHVXM1Y0RUVndpRnBOb3pDSmlwZXh6dUV0?=
 =?utf-8?B?M3NkS1Q0Zm5VNlFkbWdUSFZZQXRJTkZYTTVrYVVLQnBtRUdQRTczQkkyNElw?=
 =?utf-8?B?TUpLQWpmaWthU21QbWdtZXNkaXVRNE9JSTY2Q2F2MkV2cXZCR2lwaFo2eVpL?=
 =?utf-8?B?bG8rUmljNkUxMElpUkpNUkVwSGlIL0U3SnRzdjB4SWR1NGh2T0hEbHJaSHdr?=
 =?utf-8?B?U3ZEcmZrby9zQ3FQcHNQTisvM3JFbDhCWGxOV3ZDY1B6cStPNlRid1pVWVh6?=
 =?utf-8?B?Y3kyOWEzdnRPazRiVzZjRUp4U3NxbjhXTWE3MG5HWUxHOUk0T1g2VjZaRU1T?=
 =?utf-8?B?a3FmamZCeEkwY2JVMXNUTWRGVkltaGRsSmVJVU1ETk84MjNQMjNsTVIra0Nq?=
 =?utf-8?B?UHdFTUNiQ1orMXRnTUJHS3l2T1RTYzdUOHJZdHZvdmVvNEVCYkEzaEFjby94?=
 =?utf-8?B?WWNPV09nV3Q0U2IzYUQ4NlRtOVYvQ01Rd2hVZmJKb0JrNGh1MjlPLzJqRVNJ?=
 =?utf-8?B?a0taTm1rc0d4eG0xMTQ0dE9HeXhnUXVadUc2MlV6YTd6ZldvcGpuTWJtTXM5?=
 =?utf-8?B?L0toZGxvOEFxWFROSGJjYjVPeGRUMXEyNE8vc21QV1ZiUmVXeDBqQXpXZTQw?=
 =?utf-8?Q?FEkMemTPrR4hNRS2kquOtNpEAAgews20=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4b82ce-9942-476a-9655-08dbd1ce3f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2023 00:39:55.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lw2b5K1bOkDpxe4zhYGuDsSvabQpPp5UvKz5iXgW9YutExLwON7XvT/sQsws1fqX5E8ik1u1tiLrtmqGgO8nwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Proofpoint-ORIG-GUID: YWb7qRPELdckP9OtWwHLW7zQ4Z2eJ5rk
X-Proofpoint-GUID: YWb7qRPELdckP9OtWwHLW7zQ4Z2eJ5rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=811 bulkscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMjAsIDIwMjMsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOg0KPiBPbiBSb2Nr
Y2hpcCBSSzM1ODggb25lIG9mIHRoZSBEV0MzIGNvcmVzIGlzIGludGVncmF0ZWQgd2VpcmRseSBh
bmQNCj4gcmVxdWlyZXMgdHdvIGV4dHJhIGNsb2NrcyB0byBiZSBlbmFibGVkLiBXaXRob3V0IHRo
ZXNlIGV4dHJhIGNsb2Nrcw0KPiBob3QtcGx1Z2dpbmcgVVNCIGRldmljZXMgaXMgYnJva2VuLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5yZWljaGVs
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8
ICA0ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gaW5kZXggMzQzZDI1NzAxODlmLi42MzliNzY4YzMzODYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
IEBAIC04NTQsOCArODU0LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19jbGtfZW5hYmxlKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBkaXNhYmxlX3JlZl9jbGs7DQo+ICAN
Cj4gKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZHdjLT51dG1pX2Nsayk7DQo+ICsJaWYgKHJl
dCkNCj4gKwkJZ290byBkaXNhYmxlX3N1c3BfY2xrOw0KPiArDQo+ICsJcmV0ID0gY2xrX3ByZXBh
cmVfZW5hYmxlKGR3Yy0+cGlwZV9jbGspOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZGlzYWJs
ZV91dG1pX2NsazsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICtkaXNhYmxlX3V0bWlfY2xr
Og0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnV0bWlfY2xrKTsNCj4gK2Rpc2FibGVf
c3VzcF9jbGs6DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+c3VzcF9jbGspOw0KPiAg
ZGlzYWJsZV9yZWZfY2xrOg0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnJlZl9jbGsp
Ow0KPiAgZGlzYWJsZV9idXNfY2xrOg0KPiBAQCAtODY1LDYgKzg3Nyw4IEBAIHN0YXRpYyBpbnQg
ZHdjM19jbGtfZW5hYmxlKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3
YzNfY2xrX2Rpc2FibGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gKwljbGtfZGlzYWJsZV91
bnByZXBhcmUoZHdjLT5waXBlX2Nsayk7DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+
dXRtaV9jbGspOw0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnN1c3BfY2xrKTsNCj4g
IAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5yZWZfY2xrKTsNCj4gIAljbGtfZGlzYWJsZV91
bnByZXBhcmUoZHdjLT5idXNfY2xrKTsNCj4gQEAgLTE3ODUsNiArMTc5OSwyMCBAQCBzdGF0aWMg
aW50IGR3YzNfZ2V0X2Nsb2NrcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQl9DQo+ICAJfQ0KPiAg
DQo+ICsJLyogc3BlY2lmaWMgdG8gUm9ja2NoaXAgUkszNTg4ICovDQo+ICsJZHdjLT51dG1pX2Ns
ayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJ1dG1pIik7DQo+ICsJaWYgKElTX0VSUihk
d2MtPnV0bWlfY2xrKSkgew0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIo
ZHdjLT51dG1pX2NsayksDQo+ICsJCQkJImNvdWxkIG5vdCBnZXQgdXRtaSBjbG9ja1xuIik7DQo+
ICsJfQ0KPiArDQo+ICsJLyogc3BlY2lmaWMgdG8gUm9ja2NoaXAgUkszNTg4ICovDQo+ICsJZHdj
LT5waXBlX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJwaXBlIik7DQo+ICsJaWYg
KElTX0VSUihkd2MtPnBpcGVfY2xrKSkgew0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IFBUUl9FUlIoZHdjLT5waXBlX2NsayksDQo+ICsJCQkJImNvdWxkIG5vdCBnZXQgcGlwZSBjbG9j
a1xuIik7DQo+ICsJfQ0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
aW5kZXggYTY5YWM2N2Q4OWZlLi5mNWU2YWU2ZTM5NGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC05
OTEsNiArOTkxLDggQEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAYnVz
X2NsazogY2xvY2sgZm9yIGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXJzDQo+ICAgKiBAcmVmX2Nsazog
cmVmZXJlbmNlIGNsb2NrDQo+ICAgKiBAc3VzcF9jbGs6IGNsb2NrIHVzZWQgd2hlbiB0aGUgU1Mg
cGh5IGlzIGluIGxvdyBwb3dlciAoUzMpIHN0YXRlDQo+ICsgKiBAdXRtaV9jbGs6IGNsb2NrIHVz
ZWQgZm9yIFVTQjIgUEhZIGNvbW11bmljYXRpb24NCj4gKyAqIEBwaXBlX2NsazogY2xvY2sgdXNl
ZCBmb3IgVVNCMyBQSFkgY29tbXVuaWNhdGlvbg0KPiAgICogQHJlc2V0OiByZXNldCBjb250cm9s
DQo+ICAgKiBAcmVnczogYmFzZSBhZGRyZXNzIGZvciBvdXIgcmVnaXN0ZXJzDQo+ICAgKiBAcmVn
c19zaXplOiBhZGRyZXNzIHNwYWNlIHNpemUNCj4gQEAgLTExNTYsNiArMTE1OCw4IEBAIHN0cnVj
dCBkd2MzIHsNCj4gIAlzdHJ1Y3QgY2xrCQkqYnVzX2NsazsNCj4gIAlzdHJ1Y3QgY2xrCQkqcmVm
X2NsazsNCj4gIAlzdHJ1Y3QgY2xrCQkqc3VzcF9jbGs7DQo+ICsJc3RydWN0IGNsawkJKnV0bWlf
Y2xrOw0KPiArCXN0cnVjdCBjbGsJCSpwaXBlX2NsazsNCj4gIA0KPiAgCXN0cnVjdCByZXNldF9j
b250cm9sCSpyZXNldDsNCj4gIA0KPiAtLSANCj4gMi40Mi4wDQo+IA0KDQpBY2tlZC1ieTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRoaW5o
