Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCC75139B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGLWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:34:43 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB51BF9;
        Wed, 12 Jul 2023 15:34:41 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CKcljT000807;
        Wed, 12 Jul 2023 15:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=d2yG625HaWclB0cPkXK2NGJkybtHaQwuYOkhZoVuBzY=;
 b=sbQg3PHOqtozOyaei/nO3gLmhlZu5HVgyoM8E/sed7NBFVlI4xCyzNFW+DRiMqqU0BPf
 s+3CHAtorWiItJ3GaDDh7QT/mreDJ49z+MKBorMCJFVhxoxonAro6msbIMMqOrNq3o5d
 0IX44QwB6HHOK8CWK9h6qHu+WYAFM2iIj5lezvvyf1YhxpMtgYaj0TvJ7uLlQ3vAeF6v
 8KvAJc3OWY2aSrkrPiwWnmegfsGWqBWHcWurZ3+//EyDH2X4tWvcuxEF+bDBa8yg0RJB
 Zfqbo6jORv+ex4+imoRfTEqLajgMzqIQ1s9mNIB+56Xs5PFF8GFu2/N6Z6pISl8aOtsG 6Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rq6ef5523-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 15:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689201253; bh=d2yG625HaWclB0cPkXK2NGJkybtHaQwuYOkhZoVuBzY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Z/A6qX7aMLVkE48PM9CkflL9053XC8W5TJZsVyPZt709xn0ricjTKgc3p3hgdRQWd
         3YSIa+YJSpc6eufKmeW13dfkF8auFM/qoUOHB9PNLR2a4bZOPcdASirux6lrqYUVCT
         nT6k8htEyKSNhAg0YYyt33ThTGHtiBYNLPlYyBTb949yWGCcNZkRv8LHXFe4bp1HCR
         0AgX/nILdWF2RDinzldTggspIjjOqSLUVOTPFWXULPMBZj6BWDgihDT4F7560qt4YH
         TxEleSacKE5N7P0mHEeHFbDiihNeVLimwpTGWwtN+pPGrdI3TO3yn0LdQnX5TjsPbw
         TH/p/3FkqYPrA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8A51140147;
        Wed, 12 Jul 2023 22:34:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7524CA008A;
        Wed, 12 Jul 2023 22:34:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=allIdHPJ;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B4AB2401C2;
        Wed, 12 Jul 2023 22:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6CRk8VFj3hV0dye3cmkA8h0I7p4pmU0RbfQoKNVDDvUNVi9aTiI/xmIOWsFOnIXHtK9LqEUik0QHBzQ4Zosudtkz+pC0W7gcQCRcZiZJWakN6404W5pFADASxaBr6uF7QubOYqKIEWIXfHdgHq83ZFYJ69U+Y/tziVRJpUDZs99ajDgjki2Cyyrqfoq0m7kSXL1I8wvsfWPFwnSCQZvyYlTCvzWV+ZNk0uSpZEa7I2+qbjad7So5hKx55rQJ4R439qoputrGiNx0uD2gZXIHJlbIFh4ExYpYrEz3oXoX9ugUNievThbrhVQ56pesJyqkIlg9Bsfu8FpLcR9q2cdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2yG625HaWclB0cPkXK2NGJkybtHaQwuYOkhZoVuBzY=;
 b=i09K/M/b897M0Jjtb/XDmgCccNT3iCgLM0w+39KB6f+wDmeoD0Ke4aVDcYTMtmdIJGdEYZwlXznEGDS8iSa8Xt5wGVudBdL3nVLx6s7Kf/rDMRQ9zzOXeVXSg3VEREwTMeqMdnbqdE0BTksOEFD9OW+KIYV60Pdsz3bgN7DPACMSH2vaFBo1ohXlEPJEMXNAppIEaoD/HUsjZRNfHBE/nmyX1rB5fkqnJMD+CKfBi77og+e30CPCPZxs+4o7Kfg+x+IqxhBsqPg4c6tuSMyUNRSOsjnxjSeL8VCAa7RlGt/zGPHelWUmiCToMYeUnvN+N2l3TrPpKRDtmqBGolLfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2yG625HaWclB0cPkXK2NGJkybtHaQwuYOkhZoVuBzY=;
 b=allIdHPJMXlbARPAaL4FbzoOhsSMiY4n0+noEGVtbHhT7GUJ3QEG4xeIK0pP2eaNNZExdltgl/k8SkxM/H2nSXcv2ine3BPvD1UTCkc3NdDeNP3CtuhWjoV5VJA7IW6om5N2EbwtBwooz0I25WNthOyOKHH45jXtFC9u2ap0rKE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 22:34:05 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 22:34:04 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Thread-Topic: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Thread-Index: AQHZtB89tzIHlPHp90GZgxtzbuqKpq+1HOyAgADpt4CAALLvgA==
Date:   Wed, 12 Jul 2023 22:34:04 +0000
Message-ID: <20230712223341.qijjcko6awbnicwy@synopsys.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-3-quic_eserrao@quicinc.com>
 <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
 <0201ab70-dff8-aa38-67c9-ca8e8ada72f0@kernel.org>
In-Reply-To: <0201ab70-dff8-aa38-67c9-ca8e8ada72f0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB7549:EE_
x-ms-office365-filtering-correlation-id: 2a9374f5-3d36-46c0-00a1-08db832818e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4ZY+zwDMXhrzcc8nQhjaECz+lZcbHcs1FnqRrxEcFLRnYMFyINCOYUMJD7MZjAhk/rXioRURAvWu2il1eDDUgb5K0zuzyTGOK16+rzCgK2uhktJDgivsAZBqhVE3J2d/Ku3gOb6ORdTYl/WtVPHMeZOKmSiB/pKdQNQgRXZl9rbWB/mj+22hW40/DX9blaDgF3UGO4DG2XILTuk7vQlSwU9aMyPG/ZdoMLCQxwA5Gv5sbOokwhYj8vNPAD2ANBryuprbN4zi7n+Z+Kk9ipmVuplNI1cZofLlIItR7rwgl3ksNbG6+xUEIe483ooOJgc3WJ6hBF+SaFd/JW0IGp9O8XweidSWQUYs186BiqZTzvtj7Rq3twaL0TYy8ehf1sYi5lnfk44zFVsFJ9/08XQJqJZrpjpsfWtYs+M6LzAswv93aZgSt2iQt7e5ZK+9ge27YoZ7bOF4s8I0UbKtACgYJCmWb0OsuN2Gqif0DV71KgC1nnsmasUMdCFIf0W9pR3xJjcEeJNRgoX+vxgoImIJeQ2eDN3SXETAoKJFWlGtnBWphlBaLdv8U2TfNQL/GvtRURRsdc1Qk4lk06UVjTSmuSNUwBO6rU39GDv2mBj6e3eCczro01U0ihQ44iIq8YW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(38070700005)(478600001)(186003)(53546011)(71200400001)(54906003)(26005)(1076003)(38100700002)(6506007)(122000001)(86362001)(8676002)(8936002)(6486002)(2616005)(2906002)(66556008)(66946007)(6916009)(76116006)(66476007)(64756008)(66446008)(4326008)(6512007)(83380400001)(5660300002)(36756003)(7416002)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDJSWmw5MC96ZWszS21YNE5pTlNCQmF6cFlIRm1EWTl5Y3MxanBpSWpNeENv?=
 =?utf-8?B?amZNbFkxZVhneVdOOU02MHYvZWtTNVh3ZDZFTzVwS1Z2Qk5PS041ellIWWlZ?=
 =?utf-8?B?RFRRMkZtdFBFSDdISWlrZitQenBIaGVQa0c4eWJWL3VJMzJnSWxhWU95YkNX?=
 =?utf-8?B?VDhRYk9FdGZxY3dQQU91MmdMek00eWpDN216OXRsb01RQU5HcTRSMGdXWWxD?=
 =?utf-8?B?S05ROHIxb3gyaTArNGNjRTRRVDJwa2pGSnBJYmh0TUV0TGNoK3dIaTl2eTha?=
 =?utf-8?B?SXU3NktOUUk2S1A4Y01rejlYUEJ5eTErV2hBU2U1OGx3QllMUGw3dGg1NHBT?=
 =?utf-8?B?cGRiQm90Z0xOM0JyWlJKZTdXVjdqeDZGRGg2M0RtcElDWVQzYXhGdmdEU3Ur?=
 =?utf-8?B?alFhdjh3NzNSWWVDQVdvVWxWL1FDbElGYlhyQVFWcFBoaUwxVm9FRllVNng1?=
 =?utf-8?B?MW95bSs4SjRoSU54eUpKYmhQbnpZL1B5OGxjU3FnQjA1L3kwd3lGUHEzYTVK?=
 =?utf-8?B?cnVFakZMZitVdVZxYmlLc2RCaHB3Sm9tMnJSMXVNbnZRcjNTOWNSNjFTemlN?=
 =?utf-8?B?dytja1VzeS9Hc2ZDQjJGemF3R0liYTlLUE9yS0JTeGdNS0F1L1V6cENWV1px?=
 =?utf-8?B?d3lpQ3ZkTm13d0Z4V2Q1NUVoekFmcVh5KzEzcHo4VFhhVVZHSUVtSUpQak9L?=
 =?utf-8?B?dmlwVVNqNkVwTzBmS25RVEg1ajJ6QmFCVmowV1lRY212aVMzbjlJQVk1SU9S?=
 =?utf-8?B?M0Roek1BVVAxdTl1Mks4VU4xS1BTSk05RVg4MklwS3ljSENqaFlMOVFPTjIw?=
 =?utf-8?B?UzdCUlJBV1VSWVBpdE9XK09FZ2x1eHZIYVN6SXpRV2Q0WkJLUG1OUEZlbEZs?=
 =?utf-8?B?NXR5RGxkNktmNGMvWmR6RXpTVWw4RFdxNEYzUG5xSTNqRnF5WWc4TldUN3o5?=
 =?utf-8?B?a2ZSeTNZVXNRVnpSNTJ1dkV4SEtsRFA4Y0luTTQvTDA2R3U1aGJmMTBWd2lY?=
 =?utf-8?B?OXU3VkN3R2RhYnNFQjlhYVRVU3F3Mml6YzMrZTQ2aTRqZEQ2dkRON3lJOHJq?=
 =?utf-8?B?NGErVzdiUm5HSWttSWtZUk9JNW82b2hOYUVtNGc3a253TXdzTkxSb01DYW1O?=
 =?utf-8?B?TmxUbStpOUxneFV0anlmYmxSU3V2VExvMzJBekJXS2pDRldXMkJIZ0RJZWJC?=
 =?utf-8?B?M3MvejlSQXQyTFBXaVBTcDhwcGhSOGl2SGhFSnc2ekpxOFdhdzNmdUtEdXNm?=
 =?utf-8?B?N3dFektPWVh6UjEvY1hKcDZLYllSVEtoWHVLUFY4aEpmbVA0ZEFGTkh5M0JE?=
 =?utf-8?B?a21venUwRTdhbkRmY3k1QWFydExFOVBnSGJqd3JjY09tRDJaaDlITkhSU25J?=
 =?utf-8?B?Zm5qUURzTlJ2UlFrbkVhcWlvSnVRU0FnSDZGaWIyYWtvRGxuM0paZXBYMVdS?=
 =?utf-8?B?NTR0TGhWVzlZajhMandiYi81N1ovWk01UHM3K1lNcGlTQ0RoRktodUNlUEcx?=
 =?utf-8?B?WjFnZ05NMUFUY2p6MktPK3ZodHMzNXRmclZLUVRxemhRSWdqV0FUUXB2QU5Y?=
 =?utf-8?B?c3pWVitKaENuZWxGOHUxZm9TQmdiM3hvSUxZTWV5MisySDJ1ditSWE5JbXhx?=
 =?utf-8?B?ZkRPL0oyMkFOZmIrVUlTQVlXUktGYzNwWVRQTGJVVlRCMUJhVjJDamhRb1k0?=
 =?utf-8?B?Q2ZSYVkvU1VtMzQ3U1BTQTNreDl4MnZSc29ybVlkNnVxNFJ6RWtIQWpJSm5r?=
 =?utf-8?B?YkRwZ29FSDRzN0ZBLy84d21MUGNtU0hFNTRyTm9rMG50UHEvQzZrUjFUTDJ6?=
 =?utf-8?B?TStYaVhuNXJCeGM0UnJ4Qm5lNG5xaGo0UFRIZjQ2VWVzMWxKOVJzRmZrbm9w?=
 =?utf-8?B?dHBmSVFQME9CbHduYXJqalo0U1RBcUlpbGhMQ3JTb3RTWHAwekloK0hwYUFp?=
 =?utf-8?B?amxqbXpUbmI4eVc5Mm5TS2VSbGZpWmdrMER0STYzbG1qY3k4a0ZxSCt3eGZ2?=
 =?utf-8?B?NEJmMEpzU3lyeFUrLzRpVStrUjB4MjJLRXQ0VXVCNWM1eUhuUUU4anRuVWJk?=
 =?utf-8?B?Q1RJOHI3QitTRzVWWHFZbVZ6ck1ZN01ZTTlUOXNyUDhST1FyWkZzaEFreFYy?=
 =?utf-8?Q?LKfd0y697I6Z/uVn2TnKPZoSc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B80502AFF56047B2DDA2A33C972743@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTdkbFFNNVh3cUx4WDJpOG9zZUl5RG5ZNmovNDZ0YkVrSWpTZlhoYVFCaVEr?=
 =?utf-8?B?eWNwQTdSUUhqSCttOXh3TXpqZFIrd2Q0b2dSLzB1Z1JtbFZuREJMV3J6Z3ZX?=
 =?utf-8?B?VFFxV2JjbThOL1ZXZ0phWVNaSWdrQnNyTnV4K05wT3hoKzVtZStuVHo0ZVQz?=
 =?utf-8?B?d1o3c2RGNVkrSnZ6V0x1MzdIMDNyZzYrUXZDVTZJVFRFYVV6cU1XSjNjaDdt?=
 =?utf-8?B?T2M0STFodWZUc1ZlOVAzSkEyWnJNU2F5UDlvY2dQZG8wL3ZWNUdTZ0wwMDFN?=
 =?utf-8?B?cVI1OGs0V2k5eEJTazg0aXRxL3ZaaUFNMW9vd1FHOXMya1ZTc29aVlcwbDla?=
 =?utf-8?B?b1ROamxDOWhFdG4yZ2tMS1BKbGxhamg3bHRNSlEzTStDNTZwMklPQm16aFp6?=
 =?utf-8?B?Rm5aSjNOVDEzM1pIelhEeWN1OEhUbEloVGNpTVBnSVlhait0bDlBeTdVSnpQ?=
 =?utf-8?B?ZXRtYmpsZXdNR0NNQmh1bGVjSmFFcWpSL2hxaGRBY1lkZjJDdmxobW1ZOWVj?=
 =?utf-8?B?QTN4ZHZ1dHZWbklYd3pLN0xneUJYS3dtd2FIb3VvUEZzRGpkL3dObHRGalRm?=
 =?utf-8?B?b3huMlBnajh0dWRFd215QWZPQ3NOVHhTN2RodVoya3JYQ3FIWjBaQ3lZS0hH?=
 =?utf-8?B?cWZ5VDlVb1dISkIwSFBKSlZCS04yU3JRYUI0T0hqYmd4QUdydE5pVmdjbERE?=
 =?utf-8?B?MFVwYUtZNTNQZVRZMk80cXZGaGxxR0FwbDNELzlLOHJNS25hUFlYYitRNkdN?=
 =?utf-8?B?T2tDOW5Md3kxNk9nU0ZrSmFVWURnSVNyZXFPOEdFNW9Mc05pcDJrcFp1ZS93?=
 =?utf-8?B?QzRUUjFrbEwyd3lKT2xJeUl5VDc1S0pxQXFZb28yQjlLZFhOeGo1MUgxU3Nv?=
 =?utf-8?B?WkV4YnpTTjlJNlNDdmtMUHB0S3V4UnMydUV0ZmhSVy9YSVoyM3dNYjY1YVVR?=
 =?utf-8?B?MHZxTmhFa1FSMnVqY29XTE9CeHY4M1IrbmQ3YmY5bjFVUkxoVG1Nbm1IZlRF?=
 =?utf-8?B?MFZUemF5dWlXWXd5Yi9qbXRWK3ZuMVdBSjhrMkI4dnpCbk1uYW5wRmI5VHBN?=
 =?utf-8?B?M0tqcFM0R1FMNUlHMmtxaHR1K0pGNUcwSnhBbnlrSGZBWk5FZTAyWFJTRjZv?=
 =?utf-8?B?amNkTzhlbVZORENzckZNTVo3VWZFK2VldnlPOUNuM0dSNUlqOCtwWUJhMi9S?=
 =?utf-8?B?OXg1dUZRZHhHZ1RLeUVRMDZocWZyYWVqK0wzdCs2YVF3NFEzcjVZUStmYkJI?=
 =?utf-8?B?U3JjdnN1Y2pwL2hIWG9IOWJHb3c4dmw0MFJCUm9HL3ZjM3g0VzFqQ1NZc0R5?=
 =?utf-8?Q?gabS2A6V3ZFCM=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9374f5-3d36-46c0-00a1-08db832818e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:34:04.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1miiXkc6T/uV6wSFiVyDarkJulaWEEUnPwzNixYWK/x52Dab1uWgi05YwZqdwG0jboeqB3i3Ly5Llqqx35KXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
X-Proofpoint-GUID: Zi4t6eR5AtZWOtUp53dhaWIxXflwg0FD
X-Proofpoint-ORIG-GUID: Zi4t6eR5AtZWOtUp53dhaWIxXflwg0FD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=785 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMTIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ICtSb2INCj4gDQo+
IE9uIDEyLzA3LzIwMjMgMDA6NTYsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUsIEp1
bCAxMSwgMjAyMywgRWxzb24gUm95IFNlcnJhbyB3cm90ZToNCj4gPj4gVGhpcyBwcm9wZXJ0eSBh
bGxvd3MgZHdjMyBydW50aW1lIHN1c3BlbmQgd2hlbiBidXMgc3VzcGVuZCBpbnRlcnJ1cHQNCj4g
Pj4gaXMgcmVjZWl2ZWQgZXZlbiB3aXRoIGNhYmxlIGNvbm5lY3RlZC4gVGhpcyB3b3VsZCBhbGxv
dyB0aGUgZHdjMw0KPiA+PiBjb250cm9sbGVyIHRvIGVudGVyIGxvdyBwb3dlciBtb2RlIGR1cmlu
ZyBidXMgc3VzcGVuZCBzY2VuYXJpby4NCj4gPj4NCj4gPj4gVGhpcyBwcm9wZXJ0eSB3b3VsZCBw
YXJ0aWN1bGFybHkgYmVuZWZpdCBkd2MzIElQcyB3aGVyZSBoaWJlcm5hdGlvbiBpcw0KPiA+PiBu
b3QgZW5hYmxlZCBhbmQgdGhlIGR3YzMgbG93IHBvd2VyIG1vZGUgZW50cnkvZXhpdCBpcyBoYW5k
bGVkIGJ5IHRoZQ0KPiA+PiBnbHVlIGRyaXZlci4gVGhlIGFzc3VtcHRpb24gaGVyZSBpcyB0aGF0
IHRoZSBwbGF0Zm9ybSB1c2luZyB0aGlzIGR0DQo+ID4+IHByb3BlcnR5IGlzIGNhcGFibGUgb2Yg
ZGV0ZWN0aW5nIHJlc3VtZSBldmVudHMgdG8gYnJpbmcgdGhlIGNvbnRyb2xsZXINCj4gPj4gb3V0
IG9mIHN1c3BlbmQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8g
PHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sIHwgNSArKysrKw0KPiA+PiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPj4g
aW5kZXggYTY5NmYyMzczMGQzLi4xOGFkOTlhMjZkZDkgMTAwNjQ0DQo+ID4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0K
PiA+PiBAQCAtNDAzLDYgKzQwMywxMSBAQCBwcm9wZXJ0aWVzOg0KPiA+PiAgICAgIGRlc2NyaXB0
aW9uOg0KPiA+PiAgICAgICAgRW5hYmxlIFVTQiByZW1vdGUgd2FrZXVwLg0KPiA+PiAgDQo+ID4+
ICsgIHNucHMsYWxsb3ctcnRzdXNwLW9uLXUzOg0KPiA+IA0KPiA+IFBsZWFzZSBzcGVsbCBvdXQg
dGhlIHdob2xlIHRoaW5nIGFzICJydHN1c3AiIGlzbid0IGNsZWFyLiBBbHNvLCBpdCdzIG5vdA0K
PiA+IGp1c3QgZm9yIFUzIHJpZ2h0PyBGb3IgaGlnaHNwZWVkLCBpdCdzIEwyLg0KPiA+IA0KPiA+
IEhvdyBhYm91dCB0aGUgbmFtZSB0aGF0IFJvZ2VyIHVzZTogInNucHMsZ2FkZ2V0LWtlZXAtY29u
bmVjdC1zeXMtc2xlZXAiDQo+IA0KPiBUaGF0IHByb3BlcnR5IHdhcyBtZWFudCB0byBrZWVwIHRo
ZSBVU0IgZGV2aWNlIGNvbnRyb2xsZXIgY29ubmVjdGVkDQo+IGR1cmluZyBzeXN0ZW0gc2xlZXAu
IFNvIHRoYXQgbmFtZSBtYXkgbm90IGJlIGFwcHJvcHJpYXRlIGhlcmUgYXMgdGhpcw0KPiBpcyBh
Ym91dCBhbGxvd2luZyBjb250cm9sbGVyIHJ1bnRpbWUgc3VzcGVuZCBkdXJpbmcgVVNCIHN1c3Bl
bmQuDQo+IA0KDQpBaC4uLiB5b3UncmUgcmlnaHQuIERvbid0IGtub3cgd2hhdCBJIHdhcyB0aGlu
a2luZy4gVGhleSdyZSBub3QgdGhlDQpzYW1lLCBhbmQgdGhleSBtYXkgbmVlZCB0byBiZSBzZXBh
cmF0ZWQuIEknbSBub3QgZ3JlYXQgd2l0aCB0aGUgbmFtaW5nLA0KYnV0IGl0IGNhbiBiZSBzb21l
dGhpbmcgbGlrZSB0aGlzOiAic25wcyxydW50aW1lLXN1c3BlbmQtb24tdXNiLXN1c3BlbmQiDQoN
CkJUVywgSSBhc3N1bWUgdGhhdCB5b3VyIHBsYXRmb3JtIChib3RoIGZyb20gUm9nZXIgYW5kIEVs
c29uKSBkb2VzIG5vdA0KdHVybiBvZmYgdGhlIGJ1cyB0aGF0IGhhbmRsZSBETUEgb2YgZXZlbnRz
IG9uIHN1c3BlbmQ/IChlLmcuIEFYSSBidXMpDQpMb29raW5nIGF0IHRoZSBjaGFuZ2UsIGl0IGxv
b2tzIGxpa2UgdGhlIGV2ZW50cyBhcmUgc3RpbGwgd3JpdHRlbiBpbiB0aGUNCmV2ZW50IGJ1ZmZl
ci4NCg0KVGhhbmtzLA0KVGhpbmg=
