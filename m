Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC57C74E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbjJLRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347394AbjJLRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:37:30 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF608728C;
        Thu, 12 Oct 2023 10:27:22 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHFpSs002418;
        Thu, 12 Oct 2023 10:26:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JNNnxF++51hi3a4S42KIriybwrGC9XWrV9Mbv3hddlE=;
 b=IhTbWxkhabhDOOAtcM2s4iclBGOJSFTySrp+xB28IJHZgIHl1R2is1MOcEZFv7Ylw4IK
 5oV3cPsSmXkRMV5O8G6ycaxneOUMPP+qO3U0g6pJgpm8gnX0/Ow8hiq/9FF89ESSwKl/
 wE3k5GK40WT/c6fkJCsxDqErDCznT5TVYyacj7HpDU1cQhcwv3hdrdNPHPeMIBdsG0ct
 f3+DK4jQQuKwCLHI93Nfuw3k6CEUh2/tPOxVrr88ov6bZj6Hzhs9MQUhhDa7OjrSanST
 V5jC2gNOEzo0XvgNjORc3bblPwgpfYJsf2L83252GSMPoocBq6iYbzNomiocb/Sk4PqD Jg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tkh4j2gjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697131611; bh=JNNnxF++51hi3a4S42KIriybwrGC9XWrV9Mbv3hddlE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WVXue5z/eq5K6JOhwRLiZ5cf718UOLoPZi/RGaO7OjQMKK4zdpvsGHcuVSjKc8B+H
         0HmOXDbbxANjj/Q0QjPywqQPtoMO8Mfb9+YmqO/MkTutHGbIzxcl4mt0wsI397/tFQ
         zLVefEy+JwBC6Ky61Cfc9xTLanff9+EHPyCsNlsty0ib6Pvhucz6uuttFEzwzspwHp
         ifiabppB8fDv/UyISnxiBCBj1znCukiep2ru4wCE/ImanS2+PGRFz6LNQSembUGUYg
         m7MvoEnMG47rbayAg1AO+rWMfEBfB+O6cOnRjAwjPDp/gl9e2RVAm+Ram7Cmjc4e9j
         yxv/GDsVsHZPQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4FD18405C5;
        Thu, 12 Oct 2023 17:26:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98AF3A005C;
        Thu, 12 Oct 2023 17:26:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KnJyrGPS;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B83E74013F;
        Thu, 12 Oct 2023 17:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C84dO9xo4/o9PBGKW1kdfHN2o1Oev9qCY4YAgvJCjPGn+GFcapCwD8o+glNlxF/YsxPXZs2ZsxF/rk/glg6ysLMVGDBnT84EDDcT5OSzadkCTjdomBWLnvsVBvnZrpvMWO/zdZE4tJPsXOjyaxC4gTK8BlOdIfKUEGYmrYN15Z7DIvrKVQjfW4D70C+5gDBVedZofHlef3moGUzi1xcewvgqAeOYOhd2KgeN8Mqyh7ju8QuwO4d9WDUOyNymg5/HIm/FaGNZTMe/LMUTsyYsF0xpLXEA9a+xtA8lG9XdMddCEUfwLMFGUKgkewI9vyN9oZ16GQl/Zmsyxz5F4UF7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNNnxF++51hi3a4S42KIriybwrGC9XWrV9Mbv3hddlE=;
 b=T0nYHMZY6rWJXnGc2hidkeqruarPjDzthE7bL+P0FJffaPrADhTkRKZUmB8seekUqDcCROwCObOQhAXUeneoxoIwP8pYX9FXeINkDVIwsTr7gH5FHKXWuQGRrCYq9TyPCuWy38LC8k+nZdVM9bjYQaQxJTEX021Aef20IYRYuhIyYrZg47ACW0Rk2isxzhcIn5V4ctvSw96/bY8GhhLmPMm5ydXHKCOUxuVOzHBm9vede6jGK4p0FMIwq5mYkWC/IK5/J3G/1XdsI0rl3pkwEjgJSAqd+YPZFQcDovvbh5HjVkPwZOCjdbOcPZ6HKYE4jUJq1VwBGcnYOkzA5VHYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNNnxF++51hi3a4S42KIriybwrGC9XWrV9Mbv3hddlE=;
 b=KnJyrGPS4O7xI4UhX1ciupY/AiZzZvTYH3NpUo8DxQdr2nAa7dY3bUnoSWEvEGZKFGH2LIW7U2IcHWd3s6V9MuR1chg/L74cgRgmkhWvLR5XC44+EMCJ4yTm+iYWOF19NnOlspkLXKd95XRpzlwYLni6vVdcQQi95VF31KjheUg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 17:26:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:26:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZ+TXjhwHxV6n9ZEqWlIvxqVlM+rBGcAWA
Date:   Thu, 12 Oct 2023 17:26:43 +0000
Message-ID: <20231012172623.ut5kxdvfpofi7omk@synopsys.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-4-quic_kriskura@quicinc.com>
In-Reply-To: <20231007154806.605-4-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB7720:EE_
x-ms-office365-filtering-correlation-id: 16000841-7241-471e-13b6-08dbcb486744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8Jf1qaOgxcJu+jCzNVFUNVRZrU42cWcS1yEgp9slQUqYfVvindRxbnGTL0niJ0R/RaK0nJA50MgCqKyEV6Ta7yLcaHlOAhtKGtHv/O2vqBLU1iJghNW7NwnyOFwE6ZrDWrftITbiAJh0aab6nMBvJmXO6G2jl/p+I0urxHtFAv5xP/o7R3mq3s9xTdLODLwrKrGdzxlCC6ij4pYYIOu4CmgMDYdijx8frQGnRrXKJuyGvnUaVex2jawlr7JHywaOtGNDiOH/ujp626tpTUUa/jhRJtOP4IUEdjr9OxWcFdpdE9izREa2Yg1wA2kgFCprJoSyAw/cZk3sRN+ht3ZzczEeW2SWW6XWE0ur5wcBTzrbBhDY0ScMzVJmL+X+ynnPnO9YzskKSg6SgbjltKlbhMGV1VbFzJk+q92vEQB6652TfsvMDRhral+mGCuFBd90Q0ZJwZCj+RY4SJWXGgwbfBl5f2+hV/mghzR+Jk0/cQWX23nz7WfK0pfvlpNYmLadU+jRfZ0eattxAMqimnMbnAVIXtZMaYiOFsL8etL++PxLxK1gh4k6Q1w1yyntZNwgM1dd5kgzs/R9d+WICP2Dyh4ddGYgp4LjhJzXtcPSzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(6506007)(26005)(71200400001)(36756003)(6486002)(478600001)(966005)(1076003)(2616005)(316002)(66946007)(83380400001)(6916009)(66476007)(64756008)(66556008)(66446008)(54906003)(76116006)(38100700002)(41300700001)(8936002)(8676002)(4326008)(122000001)(5660300002)(38070700005)(2906002)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVKV1pRUTVvOG9pY3l0THB1WmNoMFc1Vi85enJoZ1FDTDBzTnZwWHZiZlhY?=
 =?utf-8?B?clIxZFZRVVM0VXlkeDluUjlFMEU1VWMzZmFPRUFuR0VyS0ErVGxlalgyblM1?=
 =?utf-8?B?TFRiVy9NRjFWSTYxeHNNR0NzRzlML1dTSEhXVi95RHhBbDRDS1UzWm10dmdO?=
 =?utf-8?B?TzdRNFZKa0ZRSkZaekFZS0lMQlVvYWhheHpuaHh0Vzh2U25GSDQ5bmUzUVkz?=
 =?utf-8?B?SWhHU1k4YUQ5U1UxWjdqZUR5TGdUNjNRWEw2VHJiVFlPN0l6c2xRTTRLME9l?=
 =?utf-8?B?NE1RajU3L1BpVVpoMGZPQi9Da2RsRncxWjN1RG1iQTZORXY3RFlVSGZWMDRx?=
 =?utf-8?B?L2tRYTF4ZFptdlRyYkR3UlZPYkdVSlFLOVJkcEJSZFlpYUNJc2xNbm85RExj?=
 =?utf-8?B?YlA5Vm9PRGNiYWI3ckhDcnNVT1U5eWJMcDFYenhMSTY3bkNyZ2JQSlE5Qy9j?=
 =?utf-8?B?eEZBOGNTZ3EwUHR1ODNBU29RN1pQb1oram5HTk1FaW9LbWVKOGRTM05ESTB1?=
 =?utf-8?B?Z0pTd0RaMXNrUzFkMVdYRlFhUkJSQ3R4cFpLREFxRTR5cFV2VUR3bFVsK0Zn?=
 =?utf-8?B?VVZwNnUvVlcwVkhzRnNSWXhoK1J6Z0JROU9BK29DK3VheC9RaW8wRGl3Sy80?=
 =?utf-8?B?Z05FVUZ4T29HYS83RTlYT2FFbDdQeDhzWDMvczE5ZHdDTFdnNlplWUdyZFZO?=
 =?utf-8?B?MkVCQUU0bUpZWjRmTFNCQzROb0d4YWJmOWZOQWNmN3E1RjNPNWhtYzZaRytk?=
 =?utf-8?B?RzRTUlFiWTJxMG03YmdrckF6QUsxU2VIUmNHUkJNd3p0cGFqb2pVSEpRaEFj?=
 =?utf-8?B?MWI0cmx2akY1L2pabDVaL1FWM09kb1BnUW9ub2lERkoySXk2Z25zU3NlK0Zm?=
 =?utf-8?B?Tk5oNWJDM3BhM0NFamRGcnFDOWQ1TVplWGRZUXU5SEpKbEl5Um5STERUMCs0?=
 =?utf-8?B?dG9taVFJN3BHUWJMd2RxeUV6UkUzcnNYejNqZjBoVkxDZ2lYZ3RmVXloUEpD?=
 =?utf-8?B?WHZJeklhYUR5Q2EwSmNucnZiR1A3ZStjdVpjMGpMWEhmQ2tkUjFtUFJTNTBT?=
 =?utf-8?B?YlZNRWxENmpSNU9Lakw3b2owZ2hwRXhVWXZIRUJIYVBKZXBTNnJLVVh3Rldh?=
 =?utf-8?B?cnRTZnJYdjY1ZzhIODlTalQxZnUzbDdRS2g1dllJN1ZKeFV4UWNMS2owd1gx?=
 =?utf-8?B?a2VTUjIveThEelJjSDJlaFFkd29rNlRUNnFWK2lML0xRVjN6N0cyVmVKeUZi?=
 =?utf-8?B?Mzl6S05LYWtYRC8zek1yUVozOTExSHNZWERzSnZ1WGhDNkdlMDJYSk45TXkw?=
 =?utf-8?B?K1kwa04vUjVmUWFleVFGQWpQQ0ZLRXgyUjFSdjBkK3UzZ0dGMFpPTTJVYTg2?=
 =?utf-8?B?ZkVFQ0d6em9QanNMeW5FZHJRR2FpT0hBYVhvZzJnVEIyOGlJcU1NRm8zVHJi?=
 =?utf-8?B?QTNwcks3Q2pYZnF2b0VVQkg5S2ZncnBqNmFDckc4dWo5eGxKQ082a0VCTkEv?=
 =?utf-8?B?S2ZrT3dxQnY5WnRMZHF1alNmNXNrdkEwT2hydFBpZG5tK0dSdUk3UHhNUGVQ?=
 =?utf-8?B?ZnFycXIxK3NKUi9OUkpETjRLMkI0TlhOaHRxOG5pMmhXMVdKa284WFdoNk5I?=
 =?utf-8?B?TnFvaHB4VFM3Y1JPakp5RFlYNFZQb0I4d3ZPRFd0ZDcrajB2WUwwRUhRNkR5?=
 =?utf-8?B?TnoranVHa3cweEpzZXNKckdScG0xUTlnYi9CMkJkdmc0UGVMOGJPRFhtS2Fr?=
 =?utf-8?B?SkZsOXBOYWJ0RWMxNHlteWxHVFNtT252ODFqdTcvVjBOcDROZjdQaEE5VWk0?=
 =?utf-8?B?ZFZoalhXWm11RVYrM0c2dytyNS82ZjBJZlJLc05Kcmk0Um1MM1NlZU4xUGk0?=
 =?utf-8?B?LzQxYVgvWk84cHZhQUg2VzdEN2FsVml4RVg1TVExczVDRmRvMTBob0RYdG91?=
 =?utf-8?B?dndxSEVhMVRra3EzMzRFcVptRW9FV2ZCZUd3bkZ2bm5WdGFMTU02OURQRzQz?=
 =?utf-8?B?MnVUNUt2empqQUx5Y2VVUll5SWhCVU05VXVSa2lYYk5OZ3VWSFdocXhzOTBB?=
 =?utf-8?B?cllMZTlFRnNyYkVmOGZ6cTFSclF3ZUxtN1BlOVRMY3o4STlpZXR5RWdNd3h1?=
 =?utf-8?Q?VY+JeXeFsRQXVgjrlE9fAMXvu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B392A1CD1D2124C948BE710300A838D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmhrdjVtMWE4N1lYSEJORlB3SWVuU0tMeGpJdC9oaXA1YmoybGxwSmJVaVcw?=
 =?utf-8?B?MkhqSzJRVkp3Zk5CZmEzZStrSFRsekpDb0FHaHJyOC9pZ0FzM2wxQzBpNGpW?=
 =?utf-8?B?UXhCbjdObWc2bENHZGxVbzB2b3llZk9ZZzJIV0xib1JpK0pjeEdoL3ZHeWtO?=
 =?utf-8?B?TUNoM0g0ZnFMMEZRMVpFY0tJSTdDYjZvaDN5b0w1dUpVbHd1SGNmQ0NmUmht?=
 =?utf-8?B?WFVsKzFVTGVWaW1pS3VWcE9Kakp1ZHEwYnQ4c2NyQmdRdGtIUkVqREovSmRz?=
 =?utf-8?B?dFczY3daY2Q0UVBUM2VHQUxvM244M2pMc0JMOVlacEVXY1g1d0syUXBDQ05T?=
 =?utf-8?B?VlRvdXJDbFh1dlYzOFBSTjdrL0FtZisrQWhRS2tveUlaaDJueXczVy83VDlV?=
 =?utf-8?B?TmhneGI5UkdkanV1a015YUd5RXhjY0xZN0VXQytVKzdWb1NDdThpdFdXVFha?=
 =?utf-8?B?aGlpZk10Qi9iZml6UDg4WEtnOTlkOWVEcFg1c2lzUXRxTExVQmJ0V1FmdE5r?=
 =?utf-8?B?ZUxBaC84T1RKQ0xIQm02blhjZ1JOSXQrS3Q0MmpoWXIyOUNvbHpGY05uaXJM?=
 =?utf-8?B?blhiU3hoZFE3bjRnR2xxb0NReEJ2Mzg3bEorakRTQmVHQ040bVR0YW11b0NT?=
 =?utf-8?B?ZDVzclp3WHRYVnFuSnM1b01qWEFyS0k1OXdFNW9JTE5PVTYwSmYzdFZCYnpm?=
 =?utf-8?B?NDF3VEtla2NMOVpSZVlkQlBZWTBNVkJmeXFtL2VsTktxL2FBVGtNOHRJT1Jw?=
 =?utf-8?B?eVZsWi9qamNSSmluWGVqY0lUM3lTZFhPOXpkdzY5bnFlZE5xZGdDS0xIMm5D?=
 =?utf-8?B?RGFKdGJHTjVvekcyY0lRWGhyYyszNW5wellBbyt6d01sMnU4ZjFJK2paa1BY?=
 =?utf-8?B?UFNBdHJEQnZhMXZKanNIL05xMFBpdG93STVUc3N6Y1Rob2RvQnR3M3FCQ3Ns?=
 =?utf-8?B?ekRVQkdpbmNZY2t6RTFOS3lGclg3OGtwSEZQdkw3MTBIZWlpQTBDRDJuUkpF?=
 =?utf-8?B?WUhMMkxvN3JGV2F2UUQxbWg4dFJ4L0lOaTZtRk9pSFdxcUx3MzVUY2FFWTlj?=
 =?utf-8?B?WlVaczBkdm80Vld1YjdMa09Bc2dlRXFYeFBCS2RpcHhjV1dZMVNuRkpsSVRs?=
 =?utf-8?B?REhjbks5NTlPbWgrMHBVZEFhNStSRlhJY0Z3aWlGSEVPc2xlVHl5UzI0citQ?=
 =?utf-8?B?eFJtRW1jckJQcGdqY1M0UjhObkk1QmVUS3AvdHQ3OXlTT0sxa0FWVHl0TFlS?=
 =?utf-8?B?L1FhQ09iWUFRcjlHdGNhOUtzTlo2Q080R1Ricjk5cThmZmk2clQ5d3I2MCtG?=
 =?utf-8?B?R0xZdmJGb0hiK2M2NUM5ZENFbFFpeFc0K3ZRM0NvNXAzYWRWTFhOVVNFTCti?=
 =?utf-8?Q?bKMesncSNjQo5sVc3onsZMlTmagCPEhU=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16000841-7241-471e-13b6-08dbcb486744
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 17:26:43.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03iu1ZLazQiG3FJuVeJorS7xB1FuTOBv7F98F378Hh6GBHT+2gRyPVGq+NAl1Vz7zqpgZv5tJOLx5EMD/zQ2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
X-Proofpoint-GUID: zvrGU61FkdTXR20qIaSzz0pLGFpMvrB_
X-Proofpoint-ORIG-GUID: zvrGU61FkdTXR20qIaSzz0pLGFpMvrB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxlogscore=885 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFNhdCwgT2N0IDA3LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiBG
cm9tOiBIYXJzaCBBZ2Fyd2FsIDxxdWljX2hhcnNocUBxdWljaW5jLmNvbT4NCj4gDQo+IEN1cnJl
bnRseSB0aGUgRFdDMyBkcml2ZXIgc3VwcG9ydHMgb25seSBzaW5nbGUgcG9ydCBjb250cm9sbGVy
DQo+IHdoaWNoIHJlcXVpcmVzIGF0IG1vc3Qgb25lIEhTIGFuZCBvbmUgU1MgUEhZLg0KPiANCj4g
QnV0IHRoZSBEV0MzIFVTQiBjb250cm9sbGVyIGNhbiBiZSBjb25uZWN0ZWQgdG8gbXVsdGlwbGUg
cG9ydHMgYW5kDQo+IGVhY2ggcG9ydCBjYW4gaGF2ZSB0aGVpciBvd24gUEhZcy4gRWFjaCBwb3J0
IG9mIHRoZSBtdWx0aXBvcnQNCj4gY29udHJvbGxlciBjYW4gZWl0aGVyIGJlIEhTK1NTIGNhcGFi
bGUgb3IgSFMgb25seSBjYXBhYmxlDQo+IFByb3BlciBxdWFudGlmaWNhdGlvbiBvZiB0aGVtIGlz
IHJlcXVpcmVkIHRvIG1vZGlmeSBHVVNCMlBIWUNGRw0KPiBhbmQgR1VTQjNQSVBFQ1RMIHJlZ2lz
dGVycyBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZywgb2J0
YWluaW5nIGFuZCBjb25maWd1cmluZyBwaHkncyBzdXBwb3J0ZWQNCj4gYnkgYSBtdWx0aXBvcnQg
Y29udHJvbGxlciBhbmQuIExpbWl0IHRoZSBtYXggbnVtYmVyIG9mIHBvcnRzDQo+IHN1cHBvcnRl
ZCB0byA0IGFzIG9ubHkgU0M4MjgwIHdoaWNoIGlzIGEgcXVhZCBwb3J0IGNvbnRyb2xsZXIgc3Vw
cG9ydHMNCj4gTXVsdGlwb3J0IGN1cnJlbnRseS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMDkyMDAx
NTYuQ3hRM3lhTFktbGtwQGludGVsLmNvbS9fXzshIUE0RjJSOUdfcGchZlRjSzhRcmJFX0lHV01v
MEFZN0U2V2lfTVNCaHlOX1ExanQ4YVRzQjRzMFlUWTdsdEszcFZIeUVjNEpsQkJMM05DbFpEMXZo
S21LQ1d4WGFidWFYYVNRdmthNWVtQSQgDQo+IENvLWRldmVsb3BlZC1ieTogSGFyc2ggQWdhcndh
bCA8cXVpY19oYXJzaHFAcXVpY2luYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhhcnNoIEFnYXJ3
YWwgPHF1aWNfaGFyc2hxQHF1aWNpbmMuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6S3Jpc2huYSBL
dXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS3Jp
c2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IENoYW5n
ZXMgaW4gdjEzOg0KPiBDb21waWxlciBpc3N1ZXMgZm91bmQgYnkga2VybmVsIHRlc3Qgcm9ib3Qg
aGF2ZSBiZWVuIGZpeGVkIGFuZCB0YWdzIGFkZGVkLg0KPiBTbyByZW1vdmluZyBtYWludGFpbmVy
cyByZXZpZXdlZC1ieSB0YWcgYXMgd2UgaGF2ZSBtYWRlIGEgbWlub3IgY2hhbmdlDQo+IGluIHRo
ZSBwYXRjaC4NCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDI1MiArKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aCB8ICAxMSArLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kcmQuYyAgfCAgMTUgKystDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDE5MCBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkNCj4gDQoNClBs
ZWFzZSBjaGVjayBhbmQgYWRkcmVzcyBjaGVja3BhdGNoIGlzc3Vlcy4gWW91IGNhbiBpZ25vcmUg
dGhlIEVOT1NZUw0Kd2FybmluZ3MuDQoNCldBUk5JTkc6QkFEX1NJR05fT0ZGOiBDby1kZXZlbG9w
ZWQtYnk6IHNob3VsZCBub3QgYmUgdXNlZCB0byBhdHRyaWJ1dGUgbm9taW5hbCBwYXRjaCBhdXRo
b3IgJ0hhcnNoIEFnYXJ3YWwgPHF1aWNfaGFyc2hxQHF1aWNpbmMuY29tPicNCiM0MTogDQpDby1k
ZXZlbG9wZWQtYnk6IEhhcnNoIEFnYXJ3YWwgPHF1aWNfaGFyc2hxQHF1aWNpbmMuY29tPg0KDQpX
QVJOSU5HOkJBRF9TSUdOX09GRjogVXNlIGEgc2luZ2xlIHNwYWNlIGFmdGVyIENvLWRldmVsb3Bl
ZC1ieToNCiM0MzogDQpDby1kZXZlbG9wZWQtYnk6S3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlz
a3VyYUBxdWljaW5jLmNvbT4NCg0KV0FSTklORzpFTk9TWVM6IEVOT1NZUyBtZWFucyAnaW52YWxp
ZCBzeXNjYWxsIG5yJyBhbmQgbm90aGluZyBlbHNlDQojMzY4OiBGSUxFOiBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYzoxNDUwOg0KKwkJCWlmIChyZXQgPT0gLUVOT1NZUyB8fCByZXQgPT0gLUVOT0RF
VikNCg0KV0FSTklORzpFTk9TWVM6IEVOT1NZUyBtZWFucyAnaW52YWxpZCBzeXNjYWxsIG5yJyBh
bmQgbm90aGluZyBlbHNlDQojMzg0OiBGSUxFOiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYzoxNDY1
Og0KKwkJCWlmIChyZXQgPT0gLUVOT1NZUyB8fCByZXQgPT0gLUVOT0RFVikNCg0KQ0hFQ0s6VU5O
RUNFU1NBUllfUEFSRU5USEVTRVM6IFVubmVjZXNzYXJ5IHBhcmVudGhlc2VzIGFyb3VuZCAnZHdj
LT5udW1fdXNiMl9wb3J0cyA+IERXQzNfTUFYX1BPUlRTJw0KIzQzMjogRklMRTogZHJpdmVycy91
c2IvZHdjMy9jb3JlLmM6MTk4MDoNCisJaWYgKChkd2MtPm51bV91c2IyX3BvcnRzID4gRFdDM19N
QVhfUE9SVFMpIHx8DQorCQkoZHdjLT5udW1fdXNiM19wb3J0cyA+IERXQzNfTUFYX1BPUlRTKSkN
Cg0KQ0hFQ0s6VU5ORUNFU1NBUllfUEFSRU5USEVTRVM6IFVubmVjZXNzYXJ5IHBhcmVudGhlc2Vz
IGFyb3VuZCAnZHdjLT5udW1fdXNiM19wb3J0cyA+IERXQzNfTUFYX1BPUlRTJw0KIzQzMjogRklM
RTogZHJpdmVycy91c2IvZHdjMy9jb3JlLmM6MTk4MDoNCisJaWYgKChkd2MtPm51bV91c2IyX3Bv
cnRzID4gRFdDM19NQVhfUE9SVFMpIHx8DQorCQkoZHdjLT5udW1fdXNiM19wb3J0cyA+IERXQzNf
TUFYX1BPUlRTKSkNCg0KQ0hFQ0s6UEFSRU5USEVTSVNfQUxJR05NRU5UOiBBbGlnbm1lbnQgc2hv
dWxkIG1hdGNoIG9wZW4gcGFyZW50aGVzaXMNCiM0MzM6IEZJTEU6IGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jOjE5ODE6DQorCWlmICgoZHdjLT5udW1fdXNiMl9wb3J0cyA+IERXQzNfTUFYX1BPUlRT
KSB8fA0KKwkJKGR3Yy0+bnVtX3VzYjNfcG9ydHMgPiBEV0MzX01BWF9QT1JUUykpDQoNCldBUk5J
Tkc6VEFCU1RPUDogU3RhdGVtZW50cyBzaG91bGQgc3RhcnQgb24gYSB0YWJzdG9wDQojNDkwOiBG
SUxFOiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYzoyMzAyOg0KKwkJIGZvciAoaSA9IDA7IGkgPCBk
d2MtPm51bV91c2IyX3BvcnRzOyBpKyspIHsNCg0KdG90YWw6IDAgZXJyb3JzLCA1IHdhcm5pbmdz
LCAzIGNoZWNrcywgNDkyIGxpbmVzIGNoZWNrZWQNCg0KTk9URTogRm9yIHNvbWUgb2YgdGhlIHJl
cG9ydGVkIGRlZmVjdHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8NCiAgICAgIG1lY2hhbmlj
YWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlu
cGxhY2UuDQoNCiJbUEFUQ0ggdjEzIDAzLzEwXSB1c2I6IGR3YzM6IGNvcmU6IFJlZmFjdG9yIFBI
WSBsb2dpYyB0byBzdXBwb3J0IiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuDQoN
Cg0KQlIsDQpUaGluaA==
