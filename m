Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9477B5A37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbjJBSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbjJBSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:19:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71590CE;
        Mon,  2 Oct 2023 11:19:14 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HD3MY004007;
        Mon, 2 Oct 2023 11:18:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=nWQCCbEelkPfAHuCdmY1t2RmM1PfTAqPV8ccHfyOHSI=;
 b=PhgRf6qpgvTC1ZlW3uSK6TR6dKkYGwi/DntvQDXcj76V6/JJxqK+2Op+vysOKrjmguzG
 60Uzc3CfYOydjxXZgQc5WGAiDRkvf0QaOZqSR2b832HScZkq5WBfice7pnJ/e65LhbLa
 05miScCdh3y/UN60W7e/Nmafp7oHmDwGn6zsw5CHXOj9jdlYbCFtv1kgbPFUTNWhebE8
 Y78A4apQGEx8hSJWpYW7d7uOGyWKfjD+kQpSfSsk4T+K5tyjSkxD7jy9OQvkTrAhw/cX
 4h+xIHSw539nOocwxJa/j37xVwx9YJs+ngpRBf44z6sVBaqsc2SALCj5F6npAp1apeNT ZA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tejaejb8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 11:18:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1696270737; bh=nWQCCbEelkPfAHuCdmY1t2RmM1PfTAqPV8ccHfyOHSI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T6BxNMcL2Q+YUAjwxkgIDLZ8uDv93stXzUW0jTUPHncK88Y/ioTM8XwBArGZgNele
         zi4OGecGVhqYERQNWSD8v/lsZCKto+Xumt4LWKgjd7Zhl9Z0JGn2Z+C5Ei5E89EurJ
         qLc75/3f5wQUgWKdtGpiD1epeVbMDlvHaQ5b+ketyBFEcX0wkuMjAWl8T8Jtc8cW+F
         aadrcZFrYWAY6VKlZajNMsnvIDUMUdFqe8o0BMYEl0dZlIyYOD9e5rt64o0zt0376b
         PyT3vtVsQ6kzxs+CLXsFt1ItX/rd1fypGUikMhyNlp5w14Lxf8CrQl69pjk5772lCr
         XbN9pN2VYRdUA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E4CD401DC;
        Mon,  2 Oct 2023 18:18:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5F5B9A0077;
        Mon,  2 Oct 2023 18:18:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RyaAuYqU;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 025C44045F;
        Mon,  2 Oct 2023 18:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnsxRzZWk/XYffpTaxxj9Un4XcRmBXrliwmVWO9mT2ysvkldHl7QGBF6pgUp9wYqf2VIlkuioCXG1pIACkxej5aqPDpKYClgJSAdObtpcWTKLsXmQWCxzN3tZdnqVzeutj5c2rhXmxz2nN2uKg3C8vkGHsRDwuzoV2w/8XukBKoR2dlR8txp423fMZjCIqdvlLVRKf9+76alLpDh3xO8BWKbj4M8MAjbynmWlhUvqp1buFZ6BXsJtyKq4FCnFmQbltaLgBNaR1fjBExIB6ks8xAFJ9tP1Q1PZ64n5ROWWzDaE8w3NAq/hjBKaU3qcouTq+RHUY+MQvSFxRsHBCe/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWQCCbEelkPfAHuCdmY1t2RmM1PfTAqPV8ccHfyOHSI=;
 b=fy6PoxYN3b6R3JYLxpI0I9tB1G1jub5r6f3FBF1S3PVXE8WtBOGL+i7nJQu/xsx9OgKkZdyBBgy0iYzvrxNiS4dK8Tt+fpeweXRmhoN94YQ/gTS/4qVZm5AsJQ1RQ0qm+M7YaTJfvAVueHnwUscbik8bh0UFtKmWsJvnh7+bHfk06EMS5uWnqxNxOUPkeazGWL63vhNXzkXJk64fuCm09BlWzm+7CPw3mF/ckJm4jALP1+bIvw2ggxphEhoUWmBVvP2uIKhz1sWfj8PsmbNvF7oB22L5d0e+HRrE2ht3wjT4DJCKr9nzc3aik7nRKSvWEpz7f7BEzcR99mSYl2+/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWQCCbEelkPfAHuCdmY1t2RmM1PfTAqPV8ccHfyOHSI=;
 b=RyaAuYqUeuh/ek4Rkz9ou4pUO9aE9rSzb4xp8tSbQTki/v3DqY6lt26omxGj7aXVJ0i+7/b0RiN9Hi/wjgo7+xOYy+SlM+Mf4P3H6vjn6wJnhNLrpr7FvypKJBV75xqdrnr1xZB3lTNQKZjQ7ZMPzJzEW33WV5PPcps15DnSCE8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 18:18:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:18:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     wuliangfeng <william.wu@rock-chips.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "jianwei.zheng@rock-chips.com" <jianwei.zheng@rock-chips.com>,
        "yangbin@rock-chips.com" <yangbin@rock-chips.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
Thread-Topic: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
Thread-Index: AQHZ5GBzz8QtSevZ6keCaFk9egZLiLAWUaMAgAW/B4CAGuBgAA==
Date:   Mon, 2 Oct 2023 18:18:50 +0000
Message-ID: <20231002181852.cfucitjfacf3khnx@synopsys.com>
References: <20230911033112.3321-1-william.wu@rock-chips.com>
 <20230912000802.nb5mk4e5toojyqis@synopsys.com>
 <471bd277-3047-4157-a27d-f2fd203fb9b8@rock-chips.com>
In-Reply-To: <471bd277-3047-4157-a27d-f2fd203fb9b8@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB9219:EE_
x-ms-office365-filtering-correlation-id: 3054fdb3-4585-4581-2900-08dbc3740709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwcF4MPrs/WeZpIQPIsbP/HK3UqcA0sBjsA3EyDJQVWOD83PG3UhWwewxsvro2Jh8DopPZHhcUBo98rtY2QtjqFH7pTGiRttsrPFnRgepBLln525XWbtKTmV5sDELGTRHrqRRZhJF6+bFlQw++SPatOEV0fc3HbWuLJ7d2R6CFXmmANWTXPW+dXCcC5dUMrJuAihqLFJDIm5fK4sxP7C+68eDN5MJajhVmHePPeRxWycRgAdCo63VoDDPh2D/M928nCdFI9E7DGY4cI3pcaIj+W3DvdGVdlOMIqa1PCvRoXc6biQVYfGonayCdGqCJMwc0Jn5Z4zROIuA2JWIC+4s/tUoT8rPD359UQaVzvRm1ahX27M9o9ctkVgxxRIBW40m8QQCtFrSAyq2g7YF6Jya7hcwE6HZAuctYB8MtJCSBJ5oXti1h2YVvfTHzwPGwIfyL9Bw66ZOnyhkuFuseRHEVYmMPLb8xCWTnXgXvH5dScjw9kfka3XHKFV5kk/2b3QNF/lRCPDSRhRTPTCpKcfMVK9/CfSBLVb4q7MH61HhBUpPbwYYFIrU2ecYx2qMldJ1i/IPRVEp9HsOL1F+Tq3EbBYsKgpJa292psNx6yF5C8nfxU/352Ziua1cdDWe3sP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(6916009)(5660300002)(4326008)(8676002)(8936002)(6486002)(66446008)(66946007)(76116006)(66476007)(66556008)(41300700001)(316002)(64756008)(54906003)(71200400001)(6506007)(53546011)(2906002)(15650500001)(6512007)(2616005)(36756003)(38070700005)(86362001)(26005)(1076003)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dERidGJYY0V1SkdHbU5IUnB0MkdQKzQ2K2pWZEVra1lzY2dxNUhUaWFCOEtq?=
 =?utf-8?B?ajRoN0JzeVhxN2dtZmhSekZrZ2UvdzBRTTZUWmZScUdyMUFYbDdzd0pBV0dJ?=
 =?utf-8?B?TFlxR0x0T1o5YzdHY052cWwzaXR4VCtKMk5Tek96dVpBcWRQTGxOR3RtVm01?=
 =?utf-8?B?Y1lHQmh4bkpJMUk3dU9idjJ2cXR6b3dQamt4YlJ3Rkk4NWpnZkx5dlRRZVMx?=
 =?utf-8?B?RWlrMDVra0ZyaUJ1RXNjNW4zS2NlbTJzd3krSDRPekpqVlZ1M1BQSmVkeXVD?=
 =?utf-8?B?b3RwaXQ4SGlNLzQ2VVh0dmlkdy9YZTV2NFV3Q3NmdlJPNUZwSmoxenlhdGlz?=
 =?utf-8?B?SHlCeEJpMnZGQlJIODYwNGl1UUVHWlh5NitOak1DZWVKQ01KRUNlUUVBcWNu?=
 =?utf-8?B?QjlmYmZnZ0pQVmNLT0N1MGlYTlRHZXFxNUpjeGYycUlsbmxUMGF5aVpSVVNy?=
 =?utf-8?B?MWF5TDBLVWFOQkdQWkZtVkJTUUNjd2lLdkltN04rSkZwQStUUkF3S1haV29X?=
 =?utf-8?B?dG56a00zbHZNZ1REU2VhZURFV3ZRSmRzTy9yNVl2M09qeFdTOUMwaGlnbFVB?=
 =?utf-8?B?RE1PZ2k4MDhUUk5mSXNNcE9ja2hlUmtYcjdFS3NvY2ErN2ZBRWVIM1V6Vi96?=
 =?utf-8?B?RzV2RTF3WWVqaW4rS0hUL2szQXBlRmllR3BOY0YwZS95Tk14ckpsT0c5dTAv?=
 =?utf-8?B?WFJ2d1FMM2FBWm44VXVKN282dlNaVjJKRGFsZEtHeTRISVpualNOUnI3Q1Zm?=
 =?utf-8?B?WW9qWXNYVCtWbnM1eHNENGk4VWQ0bzJNV1dJZVhSOGIzWHBNNE5tNyt2Z2R3?=
 =?utf-8?B?VXk2WENBMEhJOWN6ZklQdnVHdXRVbkR3cDJZVit2eE9jSkkzYUY2OGtKcHpC?=
 =?utf-8?B?NGNwdGROc1AwenBQZG1tZElkWitkMHM0VStQdlRzK3V0MEN6RTN6cm5Kbktv?=
 =?utf-8?B?R1FxNWllelpXL2tJb2kzWVE3bkRLRXRkbElmaWpGV3BXZ2RGM3FkZ1VDMzl2?=
 =?utf-8?B?bFo0MnRXUXRVajRUNjh1Wm9CODB3VTczdlRLQTlGZEhkZGVXUFpPdDhLNjll?=
 =?utf-8?B?MFBsM0lrbS9Qc1lQZm4yY2IyeFBzL0lOdGJUWURkVTVlU0ludUVRWHlBT2dK?=
 =?utf-8?B?WnNJSjRHT0hYSENGZEh3RlRYVWdzcEd4NWRrNlVoajArbHFHZzJPcUpRSGhQ?=
 =?utf-8?B?TDVSb2Y3YjNzSGVBNW9RNks1MVI3Ym9SQnZCNE9TalloRjcydFEwbURBT3Nk?=
 =?utf-8?B?Vm5ETkxJTFN0WG96MlN3VmlIT3V1YnVpWEY5ZjNiRmxIak0vYmZOakdPaEpZ?=
 =?utf-8?B?dTU4ZmFTMG9iMGcvNjlYbGxub3A2aWpMeWJUMEhYZVN5QUU3dmk5U2lkbGw3?=
 =?utf-8?B?emsrOWx3SVhkdTY4MlRpdVk0c2FPQnl0cGVZUW10M1BTMER2cGRZZ0VqS1Br?=
 =?utf-8?B?UnR3ZFV5Y1NVdFZkdVA3T2t6OU4xOHIvN29EVjZPd0JuVXgvSmVWNk12ajNL?=
 =?utf-8?B?MUhYekNtNlRGZEs5ckVWMjk3NVUwT0QvNnUxTnhCRlJoN1lvTDBrTHFJdTN3?=
 =?utf-8?B?LzFST1RDbkxNVWNBb3A1SGhNUmlRMkN1dW1oaEUzV29PN3pOQUZUVmh5bmdW?=
 =?utf-8?B?QWY3dmtvQlg5TldFMVRRZ2EzL3QwNGpJSndUY2toWHVUTk44VkhOMnZQTnBZ?=
 =?utf-8?B?NE8vbVgyQk9OUTF4OWRQSUxvQXZPSUpuUE5Jb2NRdmJJUzc5M3JtYXdmZTBU?=
 =?utf-8?B?UVRXcWp5MWVaMHBlUnEwbktRa2dtbC9kQkozekd4QURMekh1VzQvcVdWc2F3?=
 =?utf-8?B?UUQ0SkZ1c0VJZnJMZkJ3ODhsVmVuU2NmdnZJUVdxWnZHOU1wVGhqajUxSExa?=
 =?utf-8?B?WW5ROFVvZzhqdG81V09JVXMrUjdwR0tNRWZJZnd3MWV3TzZHVUlGUS9YL1B1?=
 =?utf-8?B?VEZ6eWc5VzBsWUtTWGViOWlGUng1bTAzdytJNlY0cnBzeGwwc1JpYjBxMndR?=
 =?utf-8?B?SG82K1R4Mk51UVN0b2FDWWRWOENSOTY0MklpdmJGTzZmT3pMZXEzM1UrR054?=
 =?utf-8?B?YTlQekJ3dXhYRkc2N1E1T0lqeHl3M25nL3NvTXVnZ0ZDZURJM2FYTWg4T0tI?=
 =?utf-8?B?NjFpaHFBUEVmbG1FSkpoRjQ2bmdkc0FKNDZhZWFRVGZpTk80V05DTGU0emcv?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A22700EEC4F9E47B3305B41D89997F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wyeNLcR8XyzUT8SvXIdYSIr0DwZ7akC8771X8uUx9uQQs3cY5ZPXSSJqgely+1vqFfF9Ce/DELycXjqugIcAFBGjEGGO8i1+vNZuzkoltfb/yCkGb0o6gmPM2FQ9EDvX6qHCWeldzR8mNSK8K2f4lvFyXCaDZvZAG0GQBal+IXsbiuqj28ADXW1j1eFymMeFuN8Q7WKUopBPL3qhmEjfUAbnLhDiYl2Ubb0QFoRqRIGzrKnMUiNUIm60Sjo2gYwqqeKPghw7DoAXaTStiOqQ1YhdYvvaOLAIcP6OW8VethwoVElhVPLtllbhbCxXF8j9SqgzJz8CQJ/GzmDmYRmFFyiNsXjOS80ChNIQ5ba1VhwHdX9n/t3UXXhDRLxrpwrGRMMPoacJe/BS8q9sECH7eCXJoU+gc9S+8BE+bLP6MIl93qMQiTLxmr4Vjog7sxYj3hQ83zxg0gej55LbZv4kRuPkGmH6oOTJ1KJGrIWeeYRXf/WM/2OApEeUkzH+ssjm2vSQ1ILL+2kqgAZKLKAxh46T5DgRJKIWkZJ2qnXwGqZOVQMuT9WnCzmNIPtHpaAm7bs8jSBOFYyLsC+JQYVegufsY83zFDne2K9k31GdXZ72OuwJXpGoCk2PiHNnRoCyeqPEo/yAF/h9runJbQKzS6kqO5/1uQ+s2RWq4HQGUPeomKbjLdHoHaaLwCEFaTk+9p/fg6Vuu/7MDoUSD8Z1nYFzqGNeL9y2toZ92vyJbnyQjGQxzT+QH4+5FLzqLs0iyHljZkw9fJ6JYX5cgUu4oI6vThUd39kVFisHK1kBXvpl984E81+GJgH4tSLVWiR2PbXh/CoXejiPYUXp5feLcj/07FRiBg4RKVoxWkgM3KkMrwIjd08h6z5u3HIw11sCSmeMxVG5H1BDqwQNl4kaug==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3054fdb3-4585-4581-2900-08dbc3740709
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:18:50.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCKCDOPaqjiSxy4jwt1CLZZNLxlD9iGrw4SyNhuRDMsYwjKykjVEwWCo2u8krwvrr+3oSPQ6+ySg+/fsAzLIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
X-Proofpoint-GUID: _mUc7gVY5cU6Yy6nl3FrindSqIx08ABM
X-Proofpoint-ORIG-GUID: _mUc7gVY5cU6Yy6nl3FrindSqIx08ABM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=433 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310020141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBTZXAgMTUsIDIwMjMsIHd1bGlhbmdmZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IE9uIDIwMjMvOS8xMiA4OjA4LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSGksDQo+ID4g
DQo+ID4gT24gTW9uLCBTZXAgMTEsIDIwMjMsIFdpbGxpYW0gV3Ugd3JvdGU6DQo+ID4gPiBJZiB3
ZSBlbmFibGUgUE0gcnVudGltZSBhdXRvIHN1c3BlbmQgZm9yIGR3YzMgb24gcm9ja2NoaXANCj4g
PiA+IHBsYXRmb3JtcyAoZS5nLiBSSzM1NjIpLCBpdCBhbGxvd3MgdGhlIGR3YzMgY29udHJvbGxl
ciB0bw0KPiA+ID4gZW50ZXIgcnVudGltZSBzdXNwZW5kIGlmIHVzYiBjYWJsZSBkZXRhY2hlZCBh
bmQgcG93ZXIgb2ZmDQo+ID4gPiB0aGUgcG93ZXIgZG9tYWluIG9mIHRoZSBjb250cm9sbGVyLiBX
aGVuIHN5c3RlbSByZXN1bWUsIGlmDQo+ID4gPiB0aGUgZHdjMyBhbHJlYWR5IGluIHJ1bnRpbWUg
c3VzcGVuZGVkLCBpdCBTaG91bGRuJ3QgYWNjZXNzDQo+ID4gPiB0aGUgZHdjMyByZWdpc3RlcnMg
aW4gZHdjM19yZXN1bWUoKSBiZWNhdXNlIGl0cyBwb3dlciBkb21haW4NCj4gPiA+IG1heWJlIHBv
d2VyIG9mZi4NCj4gPiA+IA0KPiA+ID4gVGVzdCBvbiBSSzM1NjIgdGFibGV0LCB0aGlzIHBhdGNo
IGNhbiBoZWxwIHRvIGF2b2lkIGtlcm5lbA0KPiA+ID4gcGFuaWMgd2hlbiBhY2Nlc3NpbmcgdGhl
IGR3YzMgcmVnaXN0ZXJzIGluIGR3YzNfcmVzdW1lKCkgaWYNCj4gPiA+IHRoZSBkd2MzIGlzIGlu
IHJ1bnRpbWUgc3VzcGVuZGVkIGFuZCBpdCdzIHBvd2VyIGRvbWFpbiBpcw0KPiA+ID4gcG93ZXIg
b2ZmLg0KPiA+IFRoZSBjb250cm9sbGVyIHNob3VsZCBiZSB3b2tlbiB1cCBiZWZvcmUgdGhpcyBz
dGVwLiBDYW4geW91IHByb3ZpZGUgbW9yZQ0KPiA+IGRldGFpbCBvbiB3aGF0IGxlZCB0byB0aGlz
Pw0KPiANCj4gWWVzLCB0aGUgcG93ZXIgZG9tYWluIG9mIHRoZSB1c2IgY29udHJvbGxlciB3aWxs
IGJlIGVuYWJsZWQgYnkgdGhlIGZyYW1ld29yaw0KPiBvZsKgIHRoZSBwbSBnZW5lcmljIGRvbWFp
biBiZWZvcmUgZHdjMyByZXN1bWUgaWYgdGhlIHN5c3RlbSBlbnRlciBzdXNwZW5kIGFuZA0KPiBl
eGl0IHN1c3BlbmQgbm9ybWFsbHkuIEhvd2V2ZXIsIGluIG15IHRlc3QgY2FzZe+8jGlmIHRoZSBz
eXN0ZW0gZmFpbCB0byBlbnRlcg0KPiBzdXNwZW5kIGJlY2F1c2Ugb2Ygc29tZSBkZXZpY2VzJ3Mg
cHJvYmxlbSwgYW5kIHRoZW4gZ290byByZWNvdmVyeSBwcm9jZXNzLA0KPiB0aGUgcG93ZXIgZG9t
YWluIG9mIHRoZSB1c2IgY29udHJvbGxlciB3aWxsIG5vdCBiZSBlbmFibGUgYmVmb3JlIGR3YzMN
Cj4gcmVzdW1lLg0KDQpPay4NCg0KPiANCj4gPiBlLmcuIHNvbWUgcXVlc3Rpb25zOg0KPiA+IFdo
byBoYW5kbGVzIHRoZSB3YWtpbmcgdXAgb2YgdGhlIGNvbnRyb2xsZXI/IElzIGl0IHRoZSBwaHkg
ZHJpdmVyPyBJcw0KPiA+IHRoZSBwaHkgZHJpdmVyIG5vdCBkZXRlY3RpbmcgYSByZXN1bWU/IE9y
IGRpZCB0aGUgcmVzdW1lIGZhaWw/IERvZXMgdGhpcw0KPiA+IG9jY3VyIGNvbnNpc3RlbnRseT8N
Cj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4gDQo+IFRoaXMgaXNzdWUgb2NjdXJzIG9j
Y2FzaW9uYWxseSBvbiBSSzM1NjIgRVZCIHdpdGggVHlwZS1DIFVTQiwgYW5kIGVuYWJsZQ0KPiBh
dXRvc3VzcGVuZCBmb3IgZHdjMyBjb250cm9sbGVyLg0KPiANCj4gSGVyZSBpcyB0aGUgdGVzdCBz
dGVwczoNCj4gDQo+IDEuIFBvd2VyIG9uIHRoZSBSSzM1NjIgRVZCIGFuZCB0aGUgVHlwZS1DIFVT
QiBpbnRlcmZhY2UgaXMgaW4gdW5jb25uZWN0ZWQNCj4gc3RhdGUuDQo+IA0KPiAyLiBNYWtlc3Vy
ZSB0aGUgZHdjMyBjb250cm9sbGVyIGVudGVyIHJ1bnRpbWUgc3VzcGVuZCwgYW5kIGl0cyBwb3dl
ciBkb21haW4NCj4gaXMgZGlzYWJsZWQuDQo+IA0KPiAzLiBEbyBzeXN0ZW0gc3VzcGVuZC9yZXN1
bWUgc3RyZXNzIHRlc3QuDQo+IA0KPiA0LiBUaGUgaXNzdWUgb2NjdXJzIG9jY2FzaW9uYWxsecKg
IHdpdGggdGhlIGZvbGxvd2luZyBsb2c6DQo+IA0KPiBbwqAgMjUxLjY4MTA5MV1bIFQ0MzMxXSBQ
TTogc3VzcGVuZCBlbnRyeSAoZGVlcCkNCj4gW8KgIDI1MS43Nzg5NzVdWyBUNDMzMV0gRmlsZXN5
c3RlbXMgc3luYzogMC4wOTcgc2Vjb25kcw0KPiBbwqAgMjUxLjc3OTAyNV1bIFQ0MzMxXSBGcmVl
emluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyAuLi4gKGVsYXBzZWQgMC4wMDUNCj4gc2Vjb25kcykg
ZG9uZS4NCj4gW8KgIDI1MS43ODQ4MTldWyBUNDMzMV0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4g
W8KgIDI1MS43ODQ4NTFdWyBUNDMzMV0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNr
cyAuLi4gKGVsYXBzZWQgMC4wMDQNCj4gc2Vjb25kcykgZG9uZS4NCj4gW8KgIDI1MS43OTI3MTld
W8KgIFQ1MDNdIFtTS1dJRkkgREJHXSBza3dfc3VzcGVuZDogV29XOiBlbmFibGVkLCBza3cgZmxh
Z3M6DQo+IDB4MzAyDQo+IFvCoCAyNTEuODAzNzAxXVsgVDQzMzFdIFBNOiBkcG1fcnVuX2NhbGxi
YWNrKCk6DQo+IHBsYXRmb3JtX3BtX3N1c3BlbmQuY2ZpX2p0KzB4MC8weDggcmV0dXJucyAtMTYN
Cj4gW8KgIDI1MS44MDM3NzldW8KgwqAgVDc1XSBQTTogUE06IFBlbmRpbmcgV2FrZXVwIFNvdXJj
ZXM6IGFsYXJtdGltZXIuMC5hdXRvDQo+IFvCoCAyNTEuODAzNzg5XVsgVDQzMzFdIFBNOiBEZXZp
Y2UgYWxhcm10aW1lci4wLmENCj4gW8KgIDI1MS44MDM5MjhdWyBUNDMzMV0gUE06IFNvbWUgZGV2
aWNlcyBmYWlsZWQgdG8gc3VzcGVuZCwgb3IgZWFybHkgd2FrZQ0KPiBldmVudCBkZXRlY3RlZA0K
PiBbwqAgMjUxLjgwNDE0MV1bwqDCoCBUNzVdIFtTS1dJRkkgREJHXSBza3dfcmVzdW1lOiBza3cg
ZmxhZ3M6IDB4MzAwDQo+IFvCoCAyNTEuODA0NzE1XVvCoMKgwqAgQzJdIFNFcnJvciBJbnRlcnJ1
cHQgb24gQ1BVMiwgY29kZSAweGJmMDAwMDAwIC0tIFNFcnJvcg0KPiBbwqAgMjUxLjgwNDcyNV1b
wqDCoMKgIEMyXSBDUFU6IDIgUElEOiA0MzMxIENvbW06IGJpbmRlcjoyNTFfNCBUYWludGVkOiBH
wqDCoMKgwqDCoMKgwqANCj4gV0PCoCBFIDUuMTAuMTU3LWFuZHJvaWQxMy00LTAwMDA2LWc3M2Yz
Mzc4MDRmYmMtYWI5ODgxNzY5ICMxDQo+IFvCoCAyNTEuODA0NzMyXVvCoMKgwqAgQzJdIEhhcmR3
YXJlIG5hbWU6IFJvY2tjaGlwIFJLMzU2MiBSSzgxNyBUQUJMRVQgTFA0IEJvYXJkDQo+IChEVCkN
Cj4gW8KgIDI1MS44MDQ3MzhdW8KgwqDCoCBDMl0gcHN0YXRlOiA4MDQwMDAwNSAoTnpjdiBkYWlm
ICtQQU4gLVVBTyAtVENPIEJUWVBFPS0tKQ0KPiBbwqAgMjUxLjgwNDc0M11bwqDCoMKgIEMyXSBw
YyA6IGVsMV9hYm9ydCsweDQwLzB4NjgNCj4gW8KgIDI1MS44MDQ3NDhdW8KgwqDCoCBDMl0gbHIg
OiBlbDFfYWJvcnQrMHgyOC8weDY4DQo+IA0KPiAuLi4uLi4NCj4gDQo+IFvCoCAyNTEuODA0OTY1
XVvCoMKgwqAgQzJdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBc3luY2hyb25vdXMgU0Vy
cm9yDQo+IEludGVycnVwdA0KPiBbwqAgMjUxLjgwNDk3NF1bwqDCoMKgIEMyXSBDUFU6IDIgUElE
OiA0MzMxIENvbW06IGJpbmRlcjoyNTFfNCBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqANCj4gV0PC
oCBFIDUuMTAuMTU3LWFuZHJvaWQxMy00LTAwMDA2LWc3M2YzMzc4MDRmYmMtYWI5ODgxNzY5ICMx
DQo+IFvCoCAyNTEuODA0OTgwXVvCoMKgwqAgQzJdIEhhcmR3YXJlIG5hbWU6IFJvY2tjaGlwIFJL
MzU2MiBSSzgxNyBUQUJMRVQgTFA0IEJvYXJkDQo+IChEVCkNCj4gW8KgIDI1MS44MDQ5ODRdW8Kg
wqDCoCBDMl0gQ2FsbCB0cmFjZToNCj4gW8KgIDI1MS44MDQ5OTBdW8KgwqDCoCBDMl3CoCBkdW1w
X2JhY2t0cmFjZS5jZmlfanQrMHgwLzB4OA0KPiBbwqAgMjUxLjgwNDk5NV1bwqDCoMKgIEMyXcKg
IGR1bXBfc3RhY2tfbHZsKzB4YzAvMHgxM2MNCj4gW8KgIDI1MS44MDUwMDBdW8KgwqDCoCBDMl3C
oCBwYW5pYysweDE3NC8weDQ2OA0KPiBbwqAgMjUxLjgwNTAwNl1bwqDCoMKgIEMyXcKgIGFybTY0
X3NlcnJvcl9wYW5pYysweDFiMC8weDIwMA0KPiBbwqAgMjUxLjgwNTAxMF1bwqDCoMKgIEMyXcKg
IGRvX3NlcnJvcisweDE4NC8weDFlNA0KPiBbwqAgMjUxLjgwNTAxNl1bwqDCoMKgIEMyXcKgIGVs
MV9lcnJvcisweDk0LzB4MTE4DQo+IFvCoCAyNTEuODA1MDIwXVvCoMKgwqAgQzJdwqAgZWwxX2Fi
b3J0KzB4NDAvMHg2OA0KPiBbwqAgMjUxLjgwNTAyNl1bwqDCoMKgIEMyXcKgIGVsMV9zeW5jX2hh
bmRsZXIrMHg1OC8weDg4DQo+IFvCoCAyNTEuODA1MDMxXVvCoMKgwqAgQzJdwqAgZWwxX3N5bmMr
MHg4Yy8weDE0MA0KPiBbwqAgMjUxLjgwNTAzNV1bwqDCoMKgIEMyXcKgIGR3YzNfcmVhZGwrMHgz
MC8weDFhMA0KPiBbwqAgMjUxLjgwNTA0MF1bwqDCoMKgIEMyXcKgIGR3YzNfcGh5X3NldHVwKzB4
MzgvMHg1MTANCj4gW8KgIDI1MS44MDUwNDVdW8KgwqDCoCBDMl3CoCBkd2MzX2NvcmVfaW5pdCsw
eDY4LzB4Y2Q0DQo+IFvCoCAyNTEuODA1MDUxXVvCoMKgwqAgQzJdwqAgZHdjM19jb3JlX2luaXRf
Zm9yX3Jlc3VtZSsweDEwYy8weDI1Yw0KPiBbwqAgMjUxLjgwNTA1Nl1bwqDCoMKgIEMyXcKgIGR3
YzNfcmVzdW1lX2NvbW1vbisweDQ0LzB4M2QwDQo+IFvCoCAyNTEuODA1MDYxXVvCoMKgwqAgQzJd
wqAgZHdjM19yZXN1bWUrMHg1Yy8weGI4DQo+IFvCoCAyNTEuODA1MDY3XVvCoMKgwqAgQzJdwqAg
ZHBtX3J1bl9jYWxsYmFjaysweDcwLzB4NDg4DQo+IFvCoCAyNTEuODA1MDcxXVvCoMKgwqAgQzJd
wqAgZGV2aWNlX3Jlc3VtZSsweDI1MC8weDJmOA0KPiBbwqAgMjUxLjgwNTA3N11bwqDCoMKgIEMy
XcKgIGRwbV9yZXN1bWUrMHgyNTgvMHg5ZGMNCj4gW8KgIDI1MS44MDUwODJdW8KgwqDCoCBDMl3C
oCBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyKzB4ODUwLzB4Y2FjDQo+IA0KPiBJbiB0aGlzIGNh
c2UsIGR1cmluZyBzdXNwZW5kIHByb2Nlc3MsIGJlY2F1c2UgdGhlIGRldmljZSBhbGFybXRpbWVy
IGZhaWxlZA0KPiB0byBzdXNwZW5kLCBpdCBicmVhayB0aGUgc3lzdGVtIHN1c3BlbmQgaW4gdGhl
IGZ1bmNpdG9uDQo+IHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIoKSwgYW5kIGdvdG8gcGxhdGZv
cm1fcmVjb3ZlcigpIGRpcmVjdGx5IHdpdGhvdXQNCj4gZW5hYmxlIHRoZSBwb3dlciBkb21haW4g
b2YgdGhlIGNvbnRyb2xsZXIsIHRoZW4gdHJpZ2dlciB0aGUgS2VybmVsIHBhbmljIGluDQo+IGR3
YzNfcmVzdW1lKCkuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBkZXRhaWxzLg0KDQo+IA0KPiBGb3Ig
YSBjb21wYXJpc29uLCBpbiB0aGUgbm9ybWFsIGNhc2UsIGlmIHRoZSBzeXN0ZW0gZW50ZXIgc3Vz
cGVuZCBub3JtYWxseSwNCj4gYW5kIGFmdGVyIHRoZSBzeXN0ZW0gd2FrZXVwLCB0aGUgcG93ZXIg
ZG9tYWluIG9mIHRoZSBjb250cm9sbGVyIHdpbGwgYmUNCj4gZW5hYmxlIGJ5IHRoZSBmcmFtZXdv
cmsgb2bCoCB0aGUgcG0gZ2VuZXJpYyBkb21haW4gYmVmb3JlIGR3YzMgcmVzdW1lLg0KPiANCj4g
VGhlIGZ1bmN0aW9uIGNhbGwgc3RhY2sgbGlrZSB0aGlzOg0KPiANCj4gc3VzcGVuZF9kZXZpY2Vz
X2FuZF9lbnRlciAtLT4NCj4gDQo+IMKgwqDCoCBzdXNwZW5kX2VudGVyIC0tPg0KPiANCj4gwqDC
oMKgIMKgwqAgwqAgZHBtX3Jlc3VtZV9ub2lycSAtLT4gZHBtX25vaXJxX3Jlc3VtZV9kZXZpY2Vz
IC0tPg0KPiBkZXZpY2VfcmVzdW1lX25vaXJxIC0tPiBnZW5wZF9yZXN1bWVfbm9pcnEgLS0+IHJv
Y2tjaGlwX3BkX3Bvd2VyIO+8iGVuYWJsZQ0KPiB0aGUgcG93ZXIgZG9tYWluIG9mIHRoZSBjb250
cm9sbGVy77yJDQo+IA0KPiDCoMKgwqAgZHBtX3Jlc3VtZV9lbmQgLS0+DQo+IA0KPiDCoMKgwqDC
oMKgwqDCoMKgIGRwbV9yZXN1bWUgLS0+IGRldmljZV9yZXN1bWUgLS0+IGRwbV9ydW5fY2FsbGJh
Y2sgLS0+IGR3YzNfcmVzdW1lDQo+IChhY2Nlc3MgdGhlIGNvbnRyb2xsZXIgc2FmZWx5KQ0KPiAN
Cj4gwqDCoMKgwqDCoMKgIMKgIGRwbV9jb21wbGV0ZSAtLT4gZ2VucGRfY29tcGxldGUgLS0+IGdl
bnBkX3F1ZXVlX3Bvd2VyX29mZl93b3JrDQo+IA0KPiBzdXNwZW5kX2ZpbmlzaCAtLT4gc3VzcGVu
ZF90aGF3X3Byb2Nlc3NlcyAtLT4gZ2VucGRfcG93ZXJfb2ZmX3dvcmtfZm4gLS0+DQo+IChkaWFi
bGUgdGhlIHBvd2VyIGRvbWFpbiBvZiB0aGUgY29udHJvbGxlciB0byBtYWludGFpbiB0aGUgb3Jp
Z2luYWwgcnVudGltZcKgDQo+IHN1c3BlbmQgc3RhdGUpDQo+IA0KDQpBdCB3aGF0IHN0ZXAgZG8g
d2UgcmVzdG9yZSB0aGUgcG93ZXIgZG9tYWluIHdoZW4gdGhpcyBoYXBwZW4/IExvb2tzIGxpa2UN
CnRoZXJlJ3MgYSBtaXNzaW5nIHN0ZXAgaW4gdGhlIHN1c3BlbmQgZmFpbHVyZSByZWNvdmVyeSB0
byByZWNvdmVyIHRoZQ0KcG93ZXIgZG9tYWluLiBXaGF0IHdlJ3JlIGRvaW5nIGhlcmUgc2VlbXMg
bW9yZSBsaWtlIGEgd29ya2Fyb3VuZCB0bw0KdGhhdCwgd2hpY2ggdW5mb3J0dW5hdGVseSBtYWtl
cyB0aGUgY29kZSBsb2dpYyBsb29rcyB1bmNsZWFyIElNTy4NCg0KQ2FuIHRoaXMgYmUgZml4ZWQg
aW4gdGhlIGxvd2VyIGxheWVyPw0KDQpUaGFua3MsDQpUaGluaA==
