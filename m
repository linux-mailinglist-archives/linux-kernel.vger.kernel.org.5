Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905879DD71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbjIMBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:14:45 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF4010E6;
        Tue, 12 Sep 2023 18:14:40 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMjJ5T013874;
        Tue, 12 Sep 2023 18:14:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=uX4gxHqtLbzKDEU0NgqqV0QpPIIKn6GqULq5xjKApME=;
 b=J8YQOH0r1UAayI5E8Kv5Eo7ZtfD3/ETk22zw83xFagqtloubFXgG3sQqtNZj1IxSwSMn
 Wy3h1Q8AnQdkJM/Dd6VbBNtqAnSAb+ZQ2BiJ/vGvIuGAwJO39qUD8ISn7jqHpSYYrb/p
 vkl8CAGxo9R31j9DTDwWDOidN1G52mviBGFO3Kh5jIzpGTver8dL6In6R/0uY2/vJD1w
 qPKYic5bF5mtNceDG3r2nSlEnijwjWLxHtZwCOLgKBbGoY1Q/lCCZF80pYfN8eCc00Xu
 i0TBY9EvndQEhZnzwwsrBGVX9zz1diEmPVd673fYZF9fCAuSkPgUM/K3bcVhlMVI4yd/ EA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3t312e8hb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 18:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694567667; bh=uX4gxHqtLbzKDEU0NgqqV0QpPIIKn6GqULq5xjKApME=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bzG7nEBkhCzoj/0xaSfy3YhdUFpESepz6JQFK1ksHQUYoz5sDvMz79rfZRIlP+aSo
         IRf+4Ue3pmycDP3B4fhHu6MOeMkvJ50ZApFtPzNqjWgngK1cV+4xc/am6EqJiTSial
         XD2cZZkljNtvS2xgWmMxdAZQcuokOHVLnbweLwWA0JKqE4j19JsGInBUqxtVINmPZx
         lr5KGRpdRl6G/0WW/Dq4rBn3Z3XGk98pz9HKZ53CTf+yHZyg9yISD6coYogCfjOXeU
         uxKVoxXZGsKYZ+dDspGtaCSmdLYaE5DOLNLu2i9haJUizar8Id492WgT35eOonRnps
         GpTxHmXu50n0w==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 249EA4045D;
        Wed, 13 Sep 2023 01:14:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 44CADA007B;
        Wed, 13 Sep 2023 01:14:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qZruQmB4;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7FDFF40121;
        Wed, 13 Sep 2023 01:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcjcp3ReijfPcfEKg0sDGTcCXA5Rx+3QyukcMqc0HsNT9nRKr83UMAXc88+zGyKQLCAfL2J/8aYxjgQBgFFPKxjK+ylitVUyouGas6X8Ht0gtLpxh7aa6DF5ekYu4Xd6v559VAyOL45AvEIM8cyd3hrhw81r025009BodgHqJtFQrQKihpoGWxGOkOb533iUsC6rEou1E/tHTuDWfZIghfjNDMRr7kGIjKDpzNAOrxJSQLsQoK4rsoWnYKHE8mPfBA+kozbE14IlCTnIS6MINIfY2w4QsJIfjIRNU0aWIr8eWGbeyeZUp8TdH8F8GXcZ6s6afYXuSs90OqLV9woZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX4gxHqtLbzKDEU0NgqqV0QpPIIKn6GqULq5xjKApME=;
 b=ShY+6VxMTZJqLoXDcJdqba4b7Yzo+gnrZ7rRJD9j0HhrdKhkSABtzEpf0dP140TxIjM3+194gMNgrfq9wzi3UStvHAedp/5fdi1A/HsJVaQ40i9f6lBl8ktiiqB6MCBwJaP+wjVVMGvTSXs+m4cYq1adjKxfQtJPQDxeT0jwySMxF/XRXShDQc1A9snwxXKMGjULK9B1EBzN+el1VNK1kWG1tSCLT5wi0hYQeCDCFMcGIqkpU33QcsehKxzI7aWfERPpusdxt4I19Y2PI2gi1kwDfgvA/CSJDUnNC+o4Gb/Sw/OW3Uxa2uIH1ibKQi3w/6jgTiQTL3agkXpp9IyQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX4gxHqtLbzKDEU0NgqqV0QpPIIKn6GqULq5xjKApME=;
 b=qZruQmB4iGFCl5sY3rWolErUOh7L83Imcub6ooysRarWX1lqMVbkK9l9U0HfNr9OdtlWUhka7IJ0/307zhpg8nhiX+RfWl6p78uGyguCwzvgcACQnQZtOGFDd9y4WkVAEJ4TWErkymlvc/hRHcj8O2qJczhYuUYficoWZW9GRKU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 01:14:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 01:14:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Topic: [PATCH v3 1/2] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Index: AQHZ5TBTh26t0fWYgEyLgYbMcHtXnLAX9N2A
Date:   Wed, 13 Sep 2023 01:14:21 +0000
Message-ID: <20230913011419.amqmwmxatfkic2ss@synopsys.com>
References: <20230912041904.30721-1-stanley_chang@realtek.com>
In-Reply-To: <20230912041904.30721-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7998:EE_
x-ms-office365-filtering-correlation-id: 7948772c-0d30-4439-fa77-08dbb3f6c31f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87zqvOXI7ZH3bUCCRnqCh1I5zo+zkUSAvJJTh4ZGcdBIhW9O8+AJAzNCNHifO7grlRh6EAB8glxUFZ0y7roXSYnNVm9ptMIqd7hVA11OEHQ2s2xVliDuRE8ak1t0AWYxYrM899SI6ign6+Mql9auhH6seaYNE/ZvudisdB6J4VSZxMrVlsAN8k1QYDcLmQn0MtCnm/rVNlAkg7P3upCLMdhEIQwQNFFHutJjODr4M1rGaTtgMhdfkz2yC0kIRisbTdM3ADGt0j/Ql6csuO44O3rEpVB8+wYRYKCtiBpGAkStnn1T8p8d9maht1ErTbnHGLIjs9B6wdsdP1W1AUlSgiCLq1lvneG98BM3/0AlIpizJnoAi6cNvWuaomPH5QGoq2vLWfubbBRM+yITDaYwisdbdF2dBpcBaiyP4a7Xncdbr87PUXbNN/1eBOQJmM4pU+A0K62u711IoU5Cbo0qbc35ovlrcssC7nNFIp9wNsxh5bHJeSPoRRrC8Vkg8ven986AURqpRZqOr/iqae6m/Vw/jsaf0cAbgNv2O2JJ2ZeidwBb+s3qKGyV8gxHpjvX9cOkSB4EoH0GZD3PS6M83X6eKLbJJ/fDPv7q1WJX0sVaarivvsMLHaf4DYq1Fg01
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199024)(186009)(1800799009)(6506007)(71200400001)(6486002)(6512007)(478600001)(1076003)(2906002)(26005)(54906003)(66946007)(66446008)(76116006)(6916009)(66556008)(64756008)(66476007)(41300700001)(2616005)(8676002)(5660300002)(83380400001)(4326008)(8936002)(38100700002)(38070700005)(86362001)(36756003)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdnaXhOSGMxOHpsaXNoRFF0S0ptRzFWR05oM0lpdWpFcXRIU2JTMmkzQ0Nj?=
 =?utf-8?B?MzViRzl0Q2wzMzNFeUlwbkFNSVVSZnBmbnZjZHplWExPa3ZsV3lUcGVLWmJF?=
 =?utf-8?B?U1Juc1Rrc0xiTXNEeDBrMk5GY0duR1JqUlZqWFpZYWJzSWV6SHVPc0h0T0ZY?=
 =?utf-8?B?QzBIcjhlbFJTeVFSdUwvM2JoM1RuZXdEdEM2Zi9sWHNGRHVIWU1aMlV2WmZF?=
 =?utf-8?B?Nkt3ZkdSZ1NXS29uQk9kTUZaeGY5cm5HcldYNHlNbFpUQWthK1BNdlY2bW51?=
 =?utf-8?B?QVRGQk9jODFrYUw0MEF2Z1VTTnVlZEN1VnlSbE4yZkNTc1VQRjhNMVdhWmtq?=
 =?utf-8?B?amY3OXRvaExKV0FUeTVnMkMyYXAvRHdvQjZLakdPc1NhUEtBbExNOXQ0SlVY?=
 =?utf-8?B?b3lqdDUzNFk1T3hzVXprR2hYTllwY2w2dzh6U0p0OWlzd3k0QkQ1VHhyM1o3?=
 =?utf-8?B?NVJqdUIwc0ZhQURnOGRLeEFwNE9hSkI2eklReUhGZVpBN24xbjFHWU80Q09Y?=
 =?utf-8?B?TWZPY1hPQitGWVFHb1B6MWVZRkhuUXI0YnlvRFA0Q1VTTDF1STdMaysrVFcv?=
 =?utf-8?B?d1FGcERlWDBkZlhDY3lESjhROTJxZDlaLzJnNmQyR3crTzUzLzZ6eHgvc2pL?=
 =?utf-8?B?NlRYZFNzTGRwbHhlQ1k5RmZsbDUwZ1JNcFArYU52dVhpcE1CVUV5eDcvZm9Q?=
 =?utf-8?B?QUxxQ0oxbnNXR0dydlREQjR0Wk5vTEw0dzNXU1F4Vkd6b013ejFXbzAwU0VZ?=
 =?utf-8?B?TzlxWXcxRVJzaG1rcnVFalN2UURScEVZT0xSZkZCM1dLUy9hOXVNUTJmcjNk?=
 =?utf-8?B?OEkzUFlqcVcwdDd2SnNWU0h3Y0p6aXlMbml6SHRnWEFDSlZRZTF2WjJuVnR5?=
 =?utf-8?B?ODNBVTJDSXQzRUxLeTgvOVFVbjdRZ1IwdWlDY2g2Q2JrSDhIN1VnWVdNeXdh?=
 =?utf-8?B?MkxoWVE5R3BOS2tTeExTL0lNUDJTR3VpaWlzbzBPTGFvZ2RISnBZMFByUHZB?=
 =?utf-8?B?alJ3L1RYK1ZHbFBZWWo0Q2VJVFRGK3pCZUVaWE85eWlOcStDOGZjMldocm9h?=
 =?utf-8?B?cjE4V0s3cUt1M1FUekhXZUFERjNMcWpNaS9sYnc5K1lFUUFza3VzQTVBMGl0?=
 =?utf-8?B?alVtWFZucG5sUW1BanVYMEl5UEdEU0MrWXl2L1gwVDVYSnJZNEhvUGdUSWdF?=
 =?utf-8?B?RUY2d1V6NkNMN1ozYVlqK2pIL211SSt0UTJpUjV6RlRWZyt5REJ1VjJUQk1T?=
 =?utf-8?B?Nnc1eWpkcjMybEhCQVBSZVFvbURLY1d2NExBRlZmbWZpdjZieStUcGtKOGxw?=
 =?utf-8?B?YTk5M0RoYVl0MlFyTWFKMnpGNzBJRGZHOVFnSGRJLzJYbk9ITWtMZkdWb0lP?=
 =?utf-8?B?NmpxbFZRMWx4SVZodVA3OTFmMUhTNnhYWElvaTMxbUNXbHo0b1I3NUt2YXFq?=
 =?utf-8?B?RlNabFFxblIrcURkK2ZmRVRweSt3M1d2dTlwcjE4N2RWTDJUYkZmOE00YVVi?=
 =?utf-8?B?VDJTVjFvTXFaVG9ER1pxSk1NamdUYWhXMjBnVHdxYjB2WXpHbWNvL3BKcWxa?=
 =?utf-8?B?T3lqdzl5RGRzNHdqOHNrVjVvbXNGTHVVaDR5OG9hT21VRmZTdXUrWkZNZk9a?=
 =?utf-8?B?V2FOczczSDRlYVpMK2Qxbk5Fd0l1b05Md0pSODJTajIzWHE5bG1kQ1FiUWJv?=
 =?utf-8?B?UjlaQmlKbWFzWEZQeGR1c21hTmlSQVlHMENaUjcrbm1aMDhQdjEvaHlvenU1?=
 =?utf-8?B?Rlhmek1pNCt3dHJJdU1IZXJjb3NPaUVLOHB2aXVDREhqbDd0ZUZaeDFKU1ha?=
 =?utf-8?B?K0tXaTJUdXZJRms0SnBVMzcxL2FFNzRHa0FOK09xQytMK3pxUHUxckcybThk?=
 =?utf-8?B?cWVGOURmQmplNWM1d3lsMlV5UHdxSFpSa0o4RkEzaG5nQkpGdVYxZTFBSG5I?=
 =?utf-8?B?c21kSzk1R1ZaTjhTbEYrSlYxT2NFMks1ODFyTHB5M2h2a1Z3WmlRN2sreXls?=
 =?utf-8?B?b2poeDNDbENzeU0wK1YyQXNYWFRtZGIrbzUwYnRaNGliSkduTFFaaWg0dm4z?=
 =?utf-8?B?NGhyeG56cERnd01tOUpmM3BvQlNVZkhsU0tLd3F6TTZBTytJYjJtWmw3TTJp?=
 =?utf-8?Q?xuS8NYgpTf8HnqJtb4UIGTHB9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF3DCAA7ACAC8344967A5070495061AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RWdacEdKdnZrSllYTU4zNXVhU1VpTnlmQi9oK09aamtFWklQVk1wS3RIZ0lh?=
 =?utf-8?B?dFFjRlduK0RuQ1pVaURwVjZ5L21nNGIrRkFnTzlHalBDRFhscmdtdFVaL205?=
 =?utf-8?B?d3hPdGhZWEZIak9aM2lxRVdTUFBRaVBMaWZWZ3Y0SmZRWDBQeEJYZmc3VC92?=
 =?utf-8?B?T0JIbnJoSUptVmtqYlFreFYrcWE4T0phU3NwQ0RoUlNtK0p0dUliY3dvTlQ5?=
 =?utf-8?B?NnJqSkxBRTZ4QUp5YlB3M2VZd2FValJ0VUhmOFIzdDBQSS8reTZLNHlrN1cr?=
 =?utf-8?B?YjVNeDY1a3ZpU3JIanphYzRhZ2h2SnRZUC9oZ3FqOFJZcC9NWDdHb3pGS29s?=
 =?utf-8?B?NVZ2U3lBc0VWSWYrRVdjb2s3L3YrV0xDUXBvT0V2R3JzeFhVOThLN2krR0JZ?=
 =?utf-8?B?UXZPWE5tRi9Ib3ZzNFJTMHZBQ0dvbHBwZWZHRi9QTFpPQVZGUmQ0Y1ByRWc3?=
 =?utf-8?B?UEY2YWpyK1RrdUR1cWZ0RUl0OUdaeFlnVlU0SkhpRGhGd0Q3anQxSWVkakZz?=
 =?utf-8?B?NFZOdld0ekZZL21QUHJPVkhmKzA3V3g3ckxDOXdkaWZBSzZkZ3pjaTFXM0h1?=
 =?utf-8?B?S2Q3b3MranluRWZCTjNQNWp5TUJhampKL1NOeTV1NS81bUJSTlRwUWNVTFEy?=
 =?utf-8?B?NjNseEpHSUNzUCt6RHlVYkhEUE9hZjN1K3N2cVZOeCtabTdzcmtRcHUzak9F?=
 =?utf-8?B?anZNR25ZKzd3cWprRmdqSG5TaEJOR3NGL0wxREJqcFZJd0xSV2F1TVhCanN0?=
 =?utf-8?B?dERCSFltYk50Zm1jMzhpR1kzZFpob1duMWdvL1lxN2dqQWxnbDdlNmZPd1Ev?=
 =?utf-8?B?MVMrWEl3QUkrazFFcitrRjhaUjRnOWFFeE5nMnp6dThSQzl0dUZSS1ZlMTZK?=
 =?utf-8?B?ZWhLUjZrWm1tZnBEeVdWT0pIMUthSHlIem55Z1hBZ3RWOXVzQ003eHZ2VUhB?=
 =?utf-8?B?dHVNSHNkcWEyU2M2aUZyZHpEN2ovZ2V2b0lsVlJiMGVYem9qNGQ4UElJUGt2?=
 =?utf-8?B?eDBYa01IbnF1RVJ1bFJEcTNNUHNxWG13UVFtZUEvbGtLV0IyTjcrdGVnK0Mr?=
 =?utf-8?B?VG9PZlVHL2lmRE5jYW1xS3ZSWis3RGI5eTFQSGZnM3Q4bzZvVGhXZUVrZThq?=
 =?utf-8?B?TkVSQU4vL1NhOGZZUjFUbm4yODdqRWtTUS9Pb1UzVFlvY2JYMFdFcEpTbVdR?=
 =?utf-8?B?WXFLaGR0MWkwTUtGcUJKMlFLMnhpeDRPUkJ2OUxlODVVNjVKOHp3dHZmc2tk?=
 =?utf-8?Q?AyAZVlgB95FD451?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7948772c-0d30-4439-fa77-08dbb3f6c31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 01:14:21.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRLtC5VXPHTXXDcRJK97LqYRq+GBVKNK5iS7JxEr4zwu0pHJgDvkI0JltF8wQnRW0w9yA8j0vzDsgFpGDswLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
X-Proofpoint-GUID: u3mjsKyD495foZw7cigQbkEg4XKsZEfQ
X-Proofpoint-ORIG-GUID: u3mjsKyD495foZw7cigQbkEg4XKsZEfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IEluIFN5bm9wc3lz
J3MgZHdjMyBkYXRhIGJvb2s6DQo+IFRvIGF2b2lkIHVuZGVycnVuIGFuZCBvdmVycnVuIGR1cmlu
ZyB0aGUgYnVyc3QsIGluIGEgaGlnaC1sYXRlbmN5IGJ1cw0KPiBzeXN0ZW0gKGxpa2UgVVNCKSwg
dGhyZXNob2xkIGFuZCBidXJzdCBzaXplIGNvbnRyb2wgaXMgcHJvdmlkZWQgdGhyb3VnaA0KPiBH
VFhUSFJDRkcgYW5kIEdSWFRIUkNGRyByZWdpc3RlcnMuDQo+IA0KPiBJbiBSZWFsdGVrIERIQyBT
b0MsIERXQzMgVVNCIDMuMCB1c2VzIEFIQiBzeXN0ZW0gYnVzLiBXaGVuIGR3YzMgaXMNCj4gY29u
bmVjdGVkIHdpdGggVVNCIDIuNUcgRXRoZXJuZXQsIHRoZXJlIHdpbGwgYmUgb3ZlcnJ1biBwcm9i
bGVtLg0KPiBUaGVyZWZvcmUsIHNldHRpbmcgVFgvUlggdGhyZXNob2xkcyBjYW4gYXZvaWQgdGhp
cyBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hh
bmdAcmVhbHRlay5jb20+DQo+IC0tLQ0KPiB2MiB0byB2MyBjaGFuZ2U6DQo+ICAgICBNb3ZlIHRo
ZSB0aHJlc2hvbGQgc2V0dGluZyB0byBuZXcgZnVuY3Rpb24gZHdjM19jb25maWdfdGhyZXNob2xk
Lg0KPiAgICAgQWRkIHRoZSB0aHJlc2hvbGQgc2V0dGluZyBmb3IgdXNiMzEgYW5kIHVzYjMyDQo+
IHYxIHRvIHYyIGNoYW5nZToNCj4gICAgIEFkZCB0aGUgcHJvcGVydGllcyBmb3IgVFgvUlggdGhy
ZXNob2xkIHNldHRpbmcNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE2MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaCB8ICAxMyArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNyBpbnNlcnRpb25z
KCspLCAzNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDljNmJmMDU0ZjE1ZC4u
NDRlZTg1MjZkYzI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTA1Nyw2ICsxMDU3LDExMSBAQCBz
dGF0aWMgdm9pZCBkd2MzX3NldF9wb3dlcl9kb3duX2Nsa19zY2FsZShzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgCX0NCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM19jb25maWdfdGhyZXNob2xk
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJdTMyIHJlZzsNCj4gKwl1OCByeF90aHJfbnVt
Ow0KPiArCXU4IHJ4X21heGJ1cnN0Ow0KPiArCXU4IHR4X3Rocl9udW07DQo+ICsJdTggdHhfbWF4
YnVyc3Q7DQo+ICsNCj4gKwkvKg0KPiArCSAqIE11c3QgY29uZmlnIGJvdGggbnVtYmVyIG9mIHBh
Y2tldHMgYW5kIG1heCBidXJzdCBzZXR0aW5ncyB0byBlbmFibGUNCj4gKwkgKiBSWCBhbmQvb3Ig
VFggdGhyZXNob2xkLg0KPiArCSAqLw0KPiArCWlmICghRFdDM19JUF9JUyhEV0MzKSAmJiBkd2Mt
PmRyX21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCkgew0KPiArCQlyeF90aHJfbnVtID0gZHdjLT5y
eF90aHJfbnVtX3BrdF9wcmQ7DQo+ICsJCXJ4X21heGJ1cnN0ID0gZHdjLT5yeF9tYXhfYnVyc3Rf
cHJkOw0KPiArCQl0eF90aHJfbnVtID0gZHdjLT50eF90aHJfbnVtX3BrdF9wcmQ7DQo+ICsJCXR4
X21heGJ1cnN0ID0gZHdjLT50eF9tYXhfYnVyc3RfcHJkOw0KPiArDQo+ICsJCWlmIChyeF90aHJf
bnVtICYmIHJ4X21heGJ1cnN0KSB7DQo+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19HUlhUSFJDRkcpOw0KPiArCQkJcmVnIHw9IERXQzMxX1JYVEhSTlVNUEtUU0VMX1BSRDsN
Cj4gKw0KPiArCQkJcmVnICY9IH5EV0MzMV9SWFRIUk5VTVBLVF9QUkQofjApOw0KPiArCQkJcmVn
IHw9IERXQzMxX1JYVEhSTlVNUEtUX1BSRChyeF90aHJfbnVtKTsNCj4gKw0KPiArCQkJcmVnICY9
IH5EV0MzMV9NQVhSWEJVUlNUU0laRV9QUkQofjApOw0KPiArCQkJcmVnIHw9IERXQzMxX01BWFJY
QlVSU1RTSVpFX1BSRChyeF9tYXhidXJzdCk7DQo+ICsNCj4gKwkJCWR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HUlhUSFJDRkcsIHJlZyk7DQo+ICsJCX0NCj4gKw0KPiArCQlpZiAodHhfdGhy
X251bSAmJiB0eF9tYXhidXJzdCkgew0KPiArCQkJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfR1RYVEhSQ0ZHKTsNCj4gKwkJCXJlZyB8PSBEV0MzMV9UWFRIUk5VTVBLVFNFTF9QUkQ7
DQo+ICsNCj4gKwkJCXJlZyAmPSB+RFdDMzFfVFhUSFJOVU1QS1RfUFJEKH4wKTsNCj4gKwkJCXJl
ZyB8PSBEV0MzMV9UWFRIUk5VTVBLVF9QUkQodHhfdGhyX251bSk7DQo+ICsNCj4gKwkJCXJlZyAm
PSB+RFdDMzFfTUFYVFhCVVJTVFNJWkVfUFJEKH4wKTsNCj4gKwkJCXJlZyB8PSBEV0MzMV9NQVhU
WEJVUlNUU0laRV9QUkQodHhfbWF4YnVyc3QpOw0KPiArDQo+ICsJCQlkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR1RYVEhSQ0ZHLCByZWcpOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJcnhf
dGhyX251bSA9IGR3Yy0+cnhfdGhyX251bV9wa3Q7DQo+ICsJcnhfbWF4YnVyc3QgPSBkd2MtPnJ4
X21heF9idXJzdDsNCj4gKwl0eF90aHJfbnVtID0gZHdjLT50eF90aHJfbnVtX3BrdDsNCj4gKwl0
eF9tYXhidXJzdCA9IGR3Yy0+dHhfbWF4X2J1cnN0Ow0KPiArDQo+ICsJaWYgKERXQzNfSVBfSVMo
RFdDMykpIHsNCj4gKwkJaWYgKHJ4X3Rocl9udW0gJiYgcnhfbWF4YnVyc3QpIHsNCj4gKwkJCXJl
ZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dSWFRIUkNGRyk7DQo+ICsJCQlyZWcgfD0g
RFdDM19HUlhUSFJDRkdfUEtUQ05UU0VMOw0KPiArDQo+ICsJCQlyZWcgJj0gfkRXQzNfR1JYVEhS
Q0ZHX1JYUEtUQ05UKH4wKTsNCj4gKwkJCXJlZyB8PSBEV0MzX0dSWFRIUkNGR19SWFBLVENOVChy
eF90aHJfbnVtKTsNCj4gKw0KPiArCQkJcmVnICY9IH5EV0MzX0dSWFRIUkNGR19NQVhSWEJVUlNU
U0laRSh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDM19HUlhUSFJDRkdfTUFYUlhCVVJTVFNJWkUocnhf
bWF4YnVyc3QpOw0KPiArDQo+ICsJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1JYVEhS
Q0ZHLCByZWcpOw0KPiArCQl9DQo+ICsNCj4gKwkJaWYgKHR4X3Rocl9udW0gJiYgdHhfbWF4YnVy
c3QpIHsNCj4gKwkJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRyk7
DQo+ICsJCQlyZWcgfD0gRFdDM19HVFhUSFJDRkdfUEtUQ05UU0VMOw0KPiArDQo+ICsJCQlyZWcg
Jj0gfkRXQzNfR1RYVEhSQ0ZHX1RYUEtUQ05UKH4wKTsNCj4gKwkJCXJlZyB8PSBEV0MzX0dUWFRI
UkNGR19UWFBLVENOVCh0eF90aHJfbnVtKTsNCj4gKw0KPiArCQkJcmVnICY9IH5EV0MzX0dUWFRI
UkNGR19NQVhUWEJVUlNUU0laRSh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDM19HVFhUSFJDRkdfTUFY
VFhCVVJTVFNJWkUodHhfbWF4YnVyc3QpOw0KPiArDQo+ICsJCQlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR1RYVEhSQ0ZHLCByZWcpOw0KPiArCQl9DQo+ICsJfSBlbHNlIHsNCj4gKwkJaWYg
KHJ4X3Rocl9udW0gJiYgcnhfbWF4YnVyc3QpIHsNCj4gKwkJCXJlZyA9IGR3YzNfcmVhZGwoZHdj
LT5yZWdzLCBEV0MzX0dSWFRIUkNGRyk7DQo+ICsJCQlyZWcgfD0gRFdDMzFfR1JYVEhSQ0ZHX1BL
VENOVFNFTDsNCj4gKw0KPiArCQkJcmVnICY9IH5EV0MzMV9HUlhUSFJDRkdfUlhQS1RDTlQofjAp
Ow0KPiArCQkJcmVnIHw9IERXQzMxX0dSWFRIUkNGR19SWFBLVENOVChyeF90aHJfbnVtKTsNCj4g
Kw0KPiArCQkJcmVnICY9IH5EV0MzMV9HUlhUSFJDRkdfTUFYUlhCVVJTVFNJWkUofjApOw0KPiAr
CQkJcmVnIHw9IERXQzMxX0dSWFRIUkNGR19NQVhSWEJVUlNUU0laRShyeF9tYXhidXJzdCk7DQo+
ICsNCj4gKwkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HUlhUSFJDRkcsIHJlZyk7DQo+
ICsJCX0NCj4gKw0KPiArCQlpZiAodHhfdGhyX251bSAmJiB0eF9tYXhidXJzdCkgew0KPiArCQkJ
cmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1RYVEhSQ0ZHKTsNCj4gKwkJCXJlZyB8
PSBEV0MzMV9HVFhUSFJDRkdfUEtUQ05UU0VMOw0KPiArDQo+ICsJCQlyZWcgJj0gfkRXQzMxX0dU
WFRIUkNGR19UWFBLVENOVCh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDMzFfR1RYVEhSQ0ZHX1RYUEtU
Q05UKHR4X3Rocl9udW0pOw0KPiArDQo+ICsJCQlyZWcgJj0gfkRXQzMxX0dUWFRIUkNGR19NQVhU
WEJVUlNUU0laRSh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDMzFfR1RYVEhSQ0ZHX01BWFRYQlVSU1RT
SVpFKHR4X21heGJ1cnN0KTsNCj4gKw0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0Mz
X0dUWFRIUkNGRywgcmVnKTsNCj4gKwkJfQ0KPiArCX0NCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAg
KiBkd2MzX2NvcmVfaW5pdCAtIExvdy1sZXZlbCBpbml0aWFsaXphdGlvbiBvZiBEV0MzIENvcmUN
Cj4gICAqIEBkd2M6IFBvaW50ZXIgdG8gb3VyIGNvbnRyb2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUN
Cj4gQEAgLTEyMDksNDIgKzEzMTQsNyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNUTDEsIHJl
Zyk7DQo+ICAJfQ0KPiAgDQo+IC0JLyoNCj4gLQkgKiBNdXN0IGNvbmZpZyBib3RoIG51bWJlciBv
ZiBwYWNrZXRzIGFuZCBtYXggYnVyc3Qgc2V0dGluZ3MgdG8gZW5hYmxlDQo+IC0JICogUlggYW5k
L29yIFRYIHRocmVzaG9sZC4NCj4gLQkgKi8NCj4gLQlpZiAoIURXQzNfSVBfSVMoRFdDMykgJiYg
ZHdjLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX0hPU1QpIHsNCj4gLQkJdTggcnhfdGhyX251bSA9
IGR3Yy0+cnhfdGhyX251bV9wa3RfcHJkOw0KPiAtCQl1OCByeF9tYXhidXJzdCA9IGR3Yy0+cnhf
bWF4X2J1cnN0X3ByZDsNCj4gLQkJdTggdHhfdGhyX251bSA9IGR3Yy0+dHhfdGhyX251bV9wa3Rf
cHJkOw0KPiAtCQl1OCB0eF9tYXhidXJzdCA9IGR3Yy0+dHhfbWF4X2J1cnN0X3ByZDsNCj4gLQ0K
PiAtCQlpZiAocnhfdGhyX251bSAmJiByeF9tYXhidXJzdCkgew0KPiAtCQkJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfR1JYVEhSQ0ZHKTsNCj4gLQkJCXJlZyB8PSBEV0MzMV9SWFRI
Uk5VTVBLVFNFTF9QUkQ7DQo+IC0NCj4gLQkJCXJlZyAmPSB+RFdDMzFfUlhUSFJOVU1QS1RfUFJE
KH4wKTsNCj4gLQkJCXJlZyB8PSBEV0MzMV9SWFRIUk5VTVBLVF9QUkQocnhfdGhyX251bSk7DQo+
IC0NCj4gLQkJCXJlZyAmPSB+RFdDMzFfTUFYUlhCVVJTVFNJWkVfUFJEKH4wKTsNCj4gLQkJCXJl
ZyB8PSBEV0MzMV9NQVhSWEJVUlNUU0laRV9QUkQocnhfbWF4YnVyc3QpOw0KPiAtDQo+IC0JCQlk
d2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1JYVEhSQ0ZHLCByZWcpOw0KPiAtCQl9DQo+IC0N
Cj4gLQkJaWYgKHR4X3Rocl9udW0gJiYgdHhfbWF4YnVyc3QpIHsNCj4gLQkJCXJlZyA9IGR3YzNf
cmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRyk7DQo+IC0JCQlyZWcgfD0gRFdDMzFfVFhU
SFJOVU1QS1RTRUxfUFJEOw0KPiAtDQo+IC0JCQlyZWcgJj0gfkRXQzMxX1RYVEhSTlVNUEtUX1BS
RCh+MCk7DQo+IC0JCQlyZWcgfD0gRFdDMzFfVFhUSFJOVU1QS1RfUFJEKHR4X3Rocl9udW0pOw0K
PiAtDQo+IC0JCQlyZWcgJj0gfkRXQzMxX01BWFRYQlVSU1RTSVpFX1BSRCh+MCk7DQo+IC0JCQly
ZWcgfD0gRFdDMzFfTUFYVFhCVVJTVFNJWkVfUFJEKHR4X21heGJ1cnN0KTsNCj4gLQ0KPiAtCQkJ
ZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywgcmVnKTsNCj4gLQkJfQ0KPiAt
CX0NCj4gKwlkd2MzX2NvbmZpZ190aHJlc2hvbGQoZHdjKTsNCj4gIA0KPiAgCXJldHVybiAwOw0K
PiAgDQo+IEBAIC0xMzgwLDYgKzE0NTAsMTAgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVy
dGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXU4CQkJbHBtX255ZXRfdGhyZXNob2xkOw0KPiAg
CXU4CQkJdHhfZGVfZW1waGFzaXM7DQo+ICAJdTgJCQloaXJkX3RocmVzaG9sZDsNCj4gKwl1OAkJ
CXJ4X3Rocl9udW1fcGt0ID0gMDsNCj4gKwl1OAkJCXJ4X21heF9idXJzdCA9IDA7DQo+ICsJdTgJ
CQl0eF90aHJfbnVtX3BrdCA9IDA7DQo+ICsJdTgJCQl0eF9tYXhfYnVyc3QgPSAwOw0KPiAgCXU4
CQkJcnhfdGhyX251bV9wa3RfcHJkID0gMDsNCj4gIAl1OAkJCXJ4X21heF9idXJzdF9wcmQgPSAw
Ow0KPiAgCXU4CQkJdHhfdGhyX251bV9wa3RfcHJkID0gMDsNCj4gQEAgLTE0NDIsNiArMTUxNiwx
NCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICAJCQkJInNucHMsdXNiMi1scG0tZGlzYWJsZSIpOw0KPiAgCWR3Yy0+dXNiMl9nYWRnZXRfbHBt
X2Rpc2FibGUgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gIAkJCQkic25wcyx1
c2IyLWdhZGdldC1scG0tZGlzYWJsZSIpOw0KPiArCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4KGRl
diwgInNucHMscngtdGhyLW51bS1wa3QiLA0KPiArCQkJCSZyeF90aHJfbnVtX3BrdCk7DQo+ICsJ
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyxyeC1tYXgtYnVyc3QiLA0KPiArCQkJ
CSZyeF9tYXhfYnVyc3QpOw0KPiArCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4KGRldiwgInNucHMs
dHgtdGhyLW51bS1wa3QiLA0KPiArCQkJCSZ0eF90aHJfbnVtX3BrdCk7DQo+ICsJZGV2aWNlX3By
b3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyx0eC1tYXgtYnVyc3QiLA0KPiArCQkJCSZ0eF9tYXhf
YnVyc3QpOw0KPiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4KGRldiwgInNucHMscngtdGhyLW51
bS1wa3QtcHJkIiwNCj4gIAkJCQkmcnhfdGhyX251bV9wa3RfcHJkKTsNCj4gIAlkZXZpY2VfcHJv
cGVydHlfcmVhZF91OChkZXYsICJzbnBzLHJ4LW1heC1idXJzdC1wcmQiLA0KPiBAQCAtMTUyMyw2
ICsxNjA1LDEyIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMg
KmR3YykNCj4gIA0KPiAgCWR3Yy0+aGlyZF90aHJlc2hvbGQgPSBoaXJkX3RocmVzaG9sZDsNCj4g
IA0KPiArCWR3Yy0+cnhfdGhyX251bV9wa3QgPSByeF90aHJfbnVtX3BrdDsNCj4gKwlkd2MtPnJ4
X21heF9idXJzdCA9IHJ4X21heF9idXJzdDsNCj4gKw0KPiArCWR3Yy0+dHhfdGhyX251bV9wa3Qg
PSB0eF90aHJfbnVtX3BrdDsNCj4gKwlkd2MtPnR4X21heF9idXJzdCA9IHR4X21heF9idXJzdDsN
Cj4gKw0KPiAgCWR3Yy0+cnhfdGhyX251bV9wa3RfcHJkID0gcnhfdGhyX251bV9wa3RfcHJkOw0K
PiAgCWR3Yy0+cnhfbWF4X2J1cnN0X3ByZCA9IHJ4X21heF9idXJzdF9wcmQ7DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gaW5kZXggYTY5YWM2N2Q4OWZlLi42NzgyZWM4YmZkNjQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IEBAIC0yMTEsNiArMjExLDExIEBADQo+ICAjZGVmaW5lIERXQzNfR1JYVEhSQ0ZHX1JYUEtUQ05U
KG4pICgoKG4pICYgMHhmKSA8PCAyNCkNCj4gICNkZWZpbmUgRFdDM19HUlhUSFJDRkdfUEtUQ05U
U0VMIEJJVCgyOSkNCj4gIA0KPiArLyogR2xvYmFsIFRYIFRocmVzaG9sZCBDb25maWd1cmF0aW9u
IFJlZ2lzdGVyICovDQo+ICsjZGVmaW5lIERXQzNfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKG4p
ICgoKG4pICYgMHhmZikgPDwgMTYpDQo+ICsjZGVmaW5lIERXQzNfR1RYVEhSQ0ZHX1RYUEtUQ05U
KG4pICgoKG4pICYgMHhmKSA8PCAyNCkNCj4gKyNkZWZpbmUgRFdDM19HVFhUSFJDRkdfUEtUQ05U
U0VMIEJJVCgyOSkNCj4gKw0KPiAgLyogR2xvYmFsIFJYIFRocmVzaG9sZCBDb25maWd1cmF0aW9u
IFJlZ2lzdGVyIGZvciBEV0NfdXNiMzEgb25seSAqLw0KPiAgI2RlZmluZSBEV0MzMV9HUlhUSFJD
RkdfTUFYUlhCVVJTVFNJWkUobikJKCgobikgJiAweDFmKSA8PCAxNikNCj4gICNkZWZpbmUgRFdD
MzFfR1JYVEhSQ0ZHX1JYUEtUQ05UKG4pCQkoKChuKSAmIDB4MWYpIDw8IDIxKQ0KPiBAQCAtMTA0
NSw2ICsxMDUwLDEwIEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHRl
c3RfbW9kZV9ucjogdGVzdCBmZWF0dXJlIHNlbGVjdG9yDQo+ICAgKiBAbHBtX255ZXRfdGhyZXNo
b2xkOiBMUE0gTllFVCByZXNwb25zZSB0aHJlc2hvbGQNCj4gICAqIEBoaXJkX3RocmVzaG9sZDog
SElSRCB0aHJlc2hvbGQNCj4gKyAqIEByeF90aHJfbnVtX3BrdDogVVNCIHJlY2VpdmUgcGFja2V0
IGNvdW50DQo+ICsgKiBAcnhfbWF4X2J1cnN0OiBtYXggVVNCIHJlY2VpdmUgYnVyc3Qgc2l6ZQ0K
PiArICogQHR4X3Rocl9udW1fcGt0OiBVU0IgdHJhbnNtaXQgcGFja2V0IGNvdW50DQo+ICsgKiBA
dHhfbWF4X2J1cnN0OiBtYXggVVNCIHRyYW5zbWl0IGJ1cnN0IHNpemUNCj4gICAqIEByeF90aHJf
bnVtX3BrdF9wcmQ6IHBlcmlvZGljIEVTUyByZWNlaXZlIHBhY2tldCBjb3VudA0KPiAgICogQHJ4
X21heF9idXJzdF9wcmQ6IG1heCBwZXJpb2RpYyBFU1MgcmVjZWl2ZSBidXJzdCBzaXplDQo+ICAg
KiBAdHhfdGhyX251bV9wa3RfcHJkOiBwZXJpb2RpYyBFU1MgdHJhbnNtaXQgcGFja2V0IGNvdW50
DQo+IEBAIC0xMjczLDYgKzEyODIsMTAgQEAgc3RydWN0IGR3YzMgew0KPiAgCXU4CQkJdGVzdF9t
b2RlX25yOw0KPiAgCXU4CQkJbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCXU4CQkJaGlyZF90aHJl
c2hvbGQ7DQo+ICsJdTgJCQlyeF90aHJfbnVtX3BrdDsNCj4gKwl1OAkJCXJ4X21heF9idXJzdDsN
Cj4gKwl1OAkJCXR4X3Rocl9udW1fcGt0Ow0KPiArCXU4CQkJdHhfbWF4X2J1cnN0Ow0KPiAgCXU4
CQkJcnhfdGhyX251bV9wa3RfcHJkOw0KPiAgCXU4CQkJcnhfbWF4X2J1cnN0X3ByZDsNCj4gIAl1
OAkJCXR4X3Rocl9udW1fcGt0X3ByZDsNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6
IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhp
bmg=
