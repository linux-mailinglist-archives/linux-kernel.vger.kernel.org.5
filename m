Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A67C74F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347355AbjJLRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347370AbjJLRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:39:13 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F357CFD;
        Thu, 12 Oct 2023 10:39:10 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHNsW0029528;
        Thu, 12 Oct 2023 10:38:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=soau4FF+W8uFGwOgRMKg/Q6sKbPkhHAxgf0QtbSUUnQ=;
 b=bEhYeg8V+LCQXY+Ym81Ybd2buAzS1fWjEHG5olbwDlSQ6R0+GGo2MFXe9no3OsfE1+HT
 +kFoG/Y9hShTIOC7f7PCLQJNNGnEA2NCl4BaIjYmfPhOX6kYno8k/Il73EH/Kcc8kBPT
 wJ/YQOx4pLxtHlyc0BrLS7ZW+COfRNmdcXT5JvjRxBYXg1UBW8mrhpah71DykORqG4Fv
 Fye050+r9o2KDvOx7l1qtLA5caa3ose5fNSdtKP528VQnpl+WV9QHkceeH6Q3us3OFU5
 iIIGkzI32gBM7kUjLVkbcLq56Seb6Ct7CNJSMheoagprNCOsF0QnOApjQ62E5x/46knc Xg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tkh0pjhkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:38:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697132334; bh=soau4FF+W8uFGwOgRMKg/Q6sKbPkhHAxgf0QtbSUUnQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EIwHLUa2HtQz+0gGb1YAyokDvYMbnmBRpHa5dojEgowgm0fWF4x21ASr2hqk1GxgB
         8T7/KLHM+XHDDASNKO3SNrjpbjoJG6JuxP+6TXhZ1PuC0YKLHuqjivHUdAwfc6jp+5
         eb0n8OZK5VWc9dFbGVDq/PE138FduuzR7giyP+HxdIG9ZSb7ECRoMx7pgzLgKPzVUK
         GdQKAARegVcjN4gK8VBWGaLitePeNoKi6/4t/niTSQr6BA2L/7dRw55sUkL7R+J8yb
         lgP1IF6FvwN4QnCaqSMM+yhCH+JHIv+ugTOUF0C0Z5g+n3otXgvGeJJEq8zgx/QEpg
         6t6L0kkrpRwfg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F001B40586;
        Thu, 12 Oct 2023 17:38:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 417F6A0077;
        Thu, 12 Oct 2023 17:38:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RLmRlE7T;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1A8E04013C;
        Thu, 12 Oct 2023 17:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeriDhvJ68H4oDXhca6mBuWOvDh/8Jm1Qig2qDSoh9Cs9Vz6P4HLnDiFu2IeaFmN4c0aMY51PdZI9M4vKEOi+/FXHFf6jm8H+Nq1Kw3FKNvAOPQfHoU1LLyC5T0c/igVZRJWiKeLHVXnIHhB4C52XAOY8IKnej6FH3GofBl7Y/2FTOYx80aT/oZJRVDQfdQ9wDaWFiDFw8lN3pEFn0ZISEihcNWOVvEE5dEgy0OudZHmlsxmxfiKLxYNP+fUXeCEu6g5sdGRHPjSGGS/UyxBrkJf9CanGmCEsqf/7pq1xPgnzAnz+30Ux76ji9bXFsvKJimhJ173bRyPsno66HTE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soau4FF+W8uFGwOgRMKg/Q6sKbPkhHAxgf0QtbSUUnQ=;
 b=ANtG9MxAoNLNsD130gJimcoNpDhheB1ZJ6+Dv6QsCCDH4U/5IyIYTSf+QM3nj4cvhOtC7chQVjMYq7gDql9b5ezmIJM93wMlfD5Krcg8cFDJ2pn93dhy8WruB1Am3K4wnRhm+FCzst4CB/NPrgEFSWivD4/YKUJRmqo66nQRTBFBjYRX8pTFnK8g2HbAHRLuuxTuGt1Fy9pG07za+4tPrCky+LPZcAsnw2uKmS+NWV9YqCSzqSgjQhSNfnXXc/+1GFxW4vXVho13Co80/aIvWglGeDHm1qkFXOHe3vt9IkRFeXMfF67POi7fKTh4wOiDB+y2WvhhS0mgXIx1Uz2OgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soau4FF+W8uFGwOgRMKg/Q6sKbPkhHAxgf0QtbSUUnQ=;
 b=RLmRlE7TkjmGk/LEOwN7qPdAtxkDcoLU3Rm9oumPfDgC0LhhBX6Dgcs266qfLWQC4RYCndM4P8Gc9P1pTRzYvn6+4jGwLW+jDDzB0029Cd0HtoQqRG2qi5L1tYQHNJuyxHawe2R8kyiQTu//OboC4mQXVMs7WNh9v79czjO5SFQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 17:38:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:38:47 +0000
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
Thread-Index: AQHZ5GBzz8QtSevZ6keCaFk9egZLiLAWUaMAgAW/B4CAGuBgAIAL3Q0AgAPO+QA=
Date:   Thu, 12 Oct 2023 17:38:47 +0000
Message-ID: <20231012173828.njkiesfiigdgfnar@synopsys.com>
References: <20230911033112.3321-1-william.wu@rock-chips.com>
 <20230912000802.nb5mk4e5toojyqis@synopsys.com>
 <471bd277-3047-4157-a27d-f2fd203fb9b8@rock-chips.com>
 <20231002181852.cfucitjfacf3khnx@synopsys.com>
 <25956856-018d-4c82-a50e-0df433d8a33c@rock-chips.com>
In-Reply-To: <25956856-018d-4c82-a50e-0df433d8a33c@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW3PR12MB4586:EE_
x-ms-office365-filtering-correlation-id: 2befe61b-bc76-4c83-5a5d-08dbcb4a1709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Ekt0dkwd9m9ii8TcaZBb8FQxrE5DeMbEJkYw7JkaEsCmJ6R4yqg1GO6g/hiCzF0RZMsUgk7NNdcV4eCjPr3l43E/lzN7w0z05avaO1TXudKocwxSh9PNrIM4P9JlzmLjbNwx41GWaaBqv4I9bZmX8YGxvQcuZJj+t2pC8A/4WKhMIXZAXcoFKpWsN3pl2U4vFtlbKzBzU1Y6EGxYI0M+3aAZdAoqZ7ovm6XoqtKVsXMh/jYcXQEDfUUKCke4RuMCmyxA9nXW09U6L6RtRREN5ARw84vsRc5IwmU8OSUNCMPYufboWuPayS1hZcVWkhiNbE95iARYPj/MPjX3IYDHBpDk5b4qV1wZEmZq0Mq9aRz7oM1O7zpU8fJ50PJm7vqA/jPi7YGBIMVCVsWMtBbqGtwzc2s5MAUvSLMkf1KN/zsLs6WZwE92ujJTrtmAEZUV9x5LzRg4R/p8w9lW0yBCN+ztbMIWoNAkR+VCyAh/N/zP9h3TwG1+BJVgDqqmiW/U7jft6LOUM7y6sfXDx9Rf/PnQa+qj6JkIccKNUUsr/YMrbrszwziKwy57f0owEIN6n9A29Q5OFMDmTPdgkqfNdHxiqWLEUNjz4yUFRMA9d5BpQAQXdGA783X4T6IysBog8+HuqHN0XENlRhrDO+D5/MZlqpBcvLvrRxskMDUjgw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(3716004)(2906002)(15650500001)(86362001)(36756003)(122000001)(38100700002)(38070700005)(2616005)(76116006)(66556008)(66946007)(91956017)(54906003)(64756008)(66446008)(66476007)(41300700001)(1076003)(316002)(6916009)(26005)(6486002)(6512007)(71200400001)(53546011)(6506007)(478600001)(5660300002)(83380400001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlEzeXdwM252Q3luNngxeWNDYTlXV1NYN0tNZUUwRUpQcGZZZGZWWmhuUDNi?=
 =?utf-8?B?VXpNUmRJNTVVdXdiRWZFMHM2SmFEdmJxRVlkOUxEOHNxRTdZekE3bGJwc2tS?=
 =?utf-8?B?STI4bldIWTltU3Z5RW5JSUJrV2gxaHA2MWRlZWJjRDZJOXJmbmV6TzIvUWtk?=
 =?utf-8?B?bXA5L0pIZ0tnaHdYRGtDc25JZlhZS21CM1g0dCtBQ0xFbjE2aEE5NnB5MSta?=
 =?utf-8?B?b1BXcFdGQkpZUlVaZHlIN2ZRSFNuSnN4ZFhLMTVzNjlvU3VsZ3k1L0FOMmFw?=
 =?utf-8?B?SUJkb3BjbVJXcTlVZEVOVHR6QTFqa2o2NVBMWVJxcEdVbHVNbXNlZjd3a0xt?=
 =?utf-8?B?ajJwdXBXUTFVOUFqeWtBWjJLMCt0S2hIeGxqYzQzMjk0ME5TSkVYWlRxZVhj?=
 =?utf-8?B?N2p1SDhHVlVXTVZOR3dSd2dPLzBRSFlJUnJXOG5tSXowUGtZelZvT1l1eG5G?=
 =?utf-8?B?Y2xkUWVSQkQ0RGpYZU9WUDQyOHpNeElLM0xLcmJ4TjNJTzBPMmdqQ3hzTnZz?=
 =?utf-8?B?ekZFb0dkdDJ1NGIzRXdjTEtyYi9lT1BiNE9qN2RuWVVQaVo0RDc0UXR0L3U3?=
 =?utf-8?B?WmlsT1pqaElHcXo4WTJ0dVc0RzBIek4xZWFUdTRVSU9LdTdwMkgzODErOEhs?=
 =?utf-8?B?R2xMbTZqaXUzY0RsdE5tWU4rbHZHbFFHRmVFb0h6c0tlc0Y4MUVYY2diMjlO?=
 =?utf-8?B?L2FBUjI4S016K1FsSkYrTlBoNUhUclE3MnVHSXU1QWFhZFo3Ym5heUZmOEQv?=
 =?utf-8?B?UzdnLy90b3dkTGpab0RoRyttUVkxVTUwbGN0VTEyL3FYcU9TUEp1ZDl6ZmFX?=
 =?utf-8?B?YW1MdkFZOFVUY3VlcWs1R2lNVFhDRnE2SmdJNXVBYWVVQTM4a3pEais3cmlB?=
 =?utf-8?B?dndmN3NuYkxkQW5BM292dS9tYWhqNThiY2MvR2VnRW1YMkxhRDA4cmRFNFZM?=
 =?utf-8?B?Q2pLZHFIZkhjeTZ5ZTNtUllnQWhGUXZQam9TZ3FsY0hGUlJNUTFUMWdvL0dC?=
 =?utf-8?B?QXhkNGcvdGp0NWZUQ2U1QW5UNTVTMjA1L1NPN09KQXJSVXRySXpLUDNBRUo3?=
 =?utf-8?B?c0tpS0ZKeTJFZU82MVFOVVRkdGNSazhxTWZrNTBOdmd0WTJJdmtRQ3E4SjVD?=
 =?utf-8?B?VnUranpaS29SMUtjeTN6Q2FweEVveFE1cFRiOWNWWC9OVlYzZzBlK3E0d1hS?=
 =?utf-8?B?SHEvVXBNWGJUYTJZQmNTY2t2cTh1V3JaVnlKd3VnZmh0cWdrY2VMWWZ5RnJL?=
 =?utf-8?B?MEdxbndZRlJpRXlGakZldEk2RVduMmxEMlIwbnV2L1pwbS9rblZtTzlkdTJu?=
 =?utf-8?B?M0dYQmw1eFdFUHFqQ3pKSDBhNUt3blVaWWcwYkNqSXZmSU9LTk8rV1M1UlpD?=
 =?utf-8?B?T1h1WThFQWc3dk5nS0h5REtjNHE0ZUl2WmF1WlRtdk5mOTBlamczRWQxYzQv?=
 =?utf-8?B?bkF0TEkzeUhhK2dXaFhhVnhhNjFzN0FaQjhFZ0o1L2xFdU80UWJrQ2p3cXQz?=
 =?utf-8?B?YkZ6MW1HK1o4L2hNR3JQK21vMWJteEFydVNSTTRzbnd4QUVuVFRBUEZpUnhl?=
 =?utf-8?B?cE9KeSt6QytKU0l3RUREc2hZQURWbXFIaXZZY3JwQy95MHFiRkx2VndDNUNM?=
 =?utf-8?B?UFdjSXdNeDRkMUFVUDFNNDZQZUh2dElEK2JyNFlQVGIrb3RtK29nRGVPdVRP?=
 =?utf-8?B?YW1iM29JZVByOW5aU3VhVEV3M1ZpUGdVekw1L1llS3N4aG8yUUZaN2czajZa?=
 =?utf-8?B?a1BoM3BTWWRqSUI0S2JyTFlydkNRbnl3eTlUa1QxWk55c0dWS2pBYndraUhR?=
 =?utf-8?B?ZzE2Um5kYlJ0TG5HTndLOFluSGVXajdtWGEwZ1dBejVhM2czbVdxL1JMM2FJ?=
 =?utf-8?B?emMrQ1FYbmVBM3NMenRpT2VIL1FJeHpBd0gwQ240UjBETmlhblBFR3NTVVFa?=
 =?utf-8?B?Y0g3VGZZN2JjZEhWbHNoZUpERTc1SkdCazBTVEtNdWhYVW1VcmdGRXZ1d1NE?=
 =?utf-8?B?YUliM1dwekVjV2VyWW81QnZwb1VvODNLVk5HNEI3MFJaRXBWc2NLMUY1SVl6?=
 =?utf-8?B?UXF6QUZsSnB2MXhJMng1N0FRS0tJcFRKbW9hZEw5Z0dFR2JUZVc1WHVzbC9I?=
 =?utf-8?B?cUY2Lzd1cTFBYW9WQmppazJYUXQrMU1IK096RFFUbjcyTDhxRTQvWSszMWh4?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C257B23BC76336419CEEDEA12BF76263@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z3OcmM3++WTfwORVimwaWOHudurBi1Qr0PfjXZzlj+69E0rtE8ab3MJbUE2oesvTcKcGwu+5tTiicnCIr/C57thW/tX6mNYKRt7qG1Y3TizXs2O07XZjdOeSQ9RanTzXddmhfdqguB4f6l7LqP975DzujMBwE/X4d8G3PjlOOax+ls1gaKdXSeZDs6pXesiFUISvrK4BqfhcQAgPiSxKbjJn2WJPQm6+PJDraZfJ3VXBZddGVnqdInbAwHOTE8Ey/sn3CvjVHuKT1BnZoFUxzj7raHYVb22SWlNV1AODrM/0oQ83pIlOyefEFXt+iXbJkZrO++dqDNV0tGX0UiEAkb60YbayOuThiTHMQDvW4C3rq1fyJcMG3/O13Wapy4w95lHGILrfXKAddhVRNf1TUEg3Lr/qSROI3rRiX7+Hj5ePVylTTU+2T5peNkaKQ7muLKrxVqmvWjncSbu9TOIJ8l8dLnO2zQS0Ribnj3Y8fagK+0x0CBWuHiCIoP/a3ahXj4RhlxEfMV+ee1g4Mp/2Ru7IoOMYF6VvrPPpHdNUMqdIzG7kLoFuXirCJLjhhNBvRc1GvVV1H6USBbXZ9r7zTTmOWxVRVG2teapzMOq6o3Gn8YyZJ4ch3U1R3OY291ZzXBKyJ4kkdIoZpHu5bG9F6OC8NQjcG+aaCPm/tulubNUNw0RmHBdjCl366359ruxmLAwALrePTgRMRGVcTovkP22u8izJI8fFvh9Tg9kVzPaKiHriMH/E28UuDxE4/JNPjg9Jrw7iAJQolUHg7npSBAkmfmr8LaPAmi941LylS0RfrP8U1g9MF7aDqRFSx27tBkdlLlgZavuM2hzprNJ+9f3sxiU8vjyl507IxNCqteLEIQnI99y0uAl//WtzCu3jegKn8Zry6rDGEQEUjcK2Vw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2befe61b-bc76-4c83-5a5d-08dbcb4a1709
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 17:38:47.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeWtUqzO6/VM8PRcAvEZuuOk0gfeVNz1YB6UOooWXMIZ8pRwD9VbJeOzmY0KS5BHJmuDy5HfwLzh9JylopCjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
X-Proofpoint-ORIG-GUID: SlnFW9eSTLPe40JTSqbwRs9NGaskJsxz
X-Proofpoint-GUID: SlnFW9eSTLPe40JTSqbwRs9NGaskJsxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=622
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTAsIDIwMjMsIHd1bGlhbmdmZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IFNvcnJ5IGZvciBteSBsYXRlIHJlcGx5IGJlY2F1c2UgdGhlIG5hdGlvbmFsIGRheSBob2xp
ZGF5Lg0KPiANCj4g5ZyoIDIwMjMvMTAvMyAyOjE4LCBUaGluaCBOZ3V5ZW4g5YaZ6YGTOg0KPiA+
IE9uIEZyaSwgU2VwIDE1LCAyMDIzLCB3dWxpYW5nZmVuZyB3cm90ZToNCj4gPiA+IEhpIFRoaW5o
LA0KPiA+ID4gDQo+ID4gPiBPbiAyMDIzLzkvMTIgODowOCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgU2VwIDExLCAyMDIzLCBXaWxs
aWFtIFd1IHdyb3RlOg0KPiA+ID4gPiA+IElmIHdlIGVuYWJsZSBQTSBydW50aW1lIGF1dG8gc3Vz
cGVuZCBmb3IgZHdjMyBvbiByb2NrY2hpcA0KPiA+ID4gPiA+IHBsYXRmb3JtcyAoZS5nLiBSSzM1
NjIpLCBpdCBhbGxvd3MgdGhlIGR3YzMgY29udHJvbGxlciB0bw0KPiA+ID4gPiA+IGVudGVyIHJ1
bnRpbWUgc3VzcGVuZCBpZiB1c2IgY2FibGUgZGV0YWNoZWQgYW5kIHBvd2VyIG9mZg0KPiA+ID4g
PiA+IHRoZSBwb3dlciBkb21haW4gb2YgdGhlIGNvbnRyb2xsZXIuIFdoZW4gc3lzdGVtIHJlc3Vt
ZSwgaWYNCj4gPiA+ID4gPiB0aGUgZHdjMyBhbHJlYWR5IGluIHJ1bnRpbWUgc3VzcGVuZGVkLCBp
dCBTaG91bGRuJ3QgYWNjZXNzDQo+ID4gPiA+ID4gdGhlIGR3YzMgcmVnaXN0ZXJzIGluIGR3YzNf
cmVzdW1lKCkgYmVjYXVzZSBpdHMgcG93ZXIgZG9tYWluDQo+ID4gPiA+ID4gbWF5YmUgcG93ZXIg
b2ZmLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRlc3Qgb24gUkszNTYyIHRhYmxldCwgdGhpcyBw
YXRjaCBjYW4gaGVscCB0byBhdm9pZCBrZXJuZWwNCj4gPiA+ID4gPiBwYW5pYyB3aGVuIGFjY2Vz
c2luZyB0aGUgZHdjMyByZWdpc3RlcnMgaW4gZHdjM19yZXN1bWUoKSBpZg0KPiA+ID4gPiA+IHRo
ZSBkd2MzIGlzIGluIHJ1bnRpbWUgc3VzcGVuZGVkIGFuZCBpdCdzIHBvd2VyIGRvbWFpbiBpcw0K
PiA+ID4gPiA+IHBvd2VyIG9mZi4NCj4gPiA+ID4gVGhlIGNvbnRyb2xsZXIgc2hvdWxkIGJlIHdv
a2VuIHVwIGJlZm9yZSB0aGlzIHN0ZXAuIENhbiB5b3UgcHJvdmlkZSBtb3JlDQo+ID4gPiA+IGRl
dGFpbCBvbiB3aGF0IGxlZCB0byB0aGlzPw0KPiA+ID4gWWVzLCB0aGUgcG93ZXIgZG9tYWluIG9m
IHRoZSB1c2IgY29udHJvbGxlciB3aWxsIGJlIGVuYWJsZWQgYnkgdGhlIGZyYW1ld29yaw0KPiA+
ID4gb2bCoCB0aGUgcG0gZ2VuZXJpYyBkb21haW4gYmVmb3JlIGR3YzMgcmVzdW1lIGlmIHRoZSBz
eXN0ZW0gZW50ZXIgc3VzcGVuZCBhbmQNCj4gPiA+IGV4aXQgc3VzcGVuZCBub3JtYWxseS4gSG93
ZXZlciwgaW4gbXkgdGVzdCBjYXNl77yMaWYgdGhlIHN5c3RlbSBmYWlsIHRvIGVudGVyDQo+ID4g
PiBzdXNwZW5kIGJlY2F1c2Ugb2Ygc29tZSBkZXZpY2VzJ3MgcHJvYmxlbSwgYW5kIHRoZW4gZ290
byByZWNvdmVyeSBwcm9jZXNzLA0KPiA+ID4gdGhlIHBvd2VyIGRvbWFpbiBvZiB0aGUgdXNiIGNv
bnRyb2xsZXIgd2lsbCBub3QgYmUgZW5hYmxlIGJlZm9yZSBkd2MzDQo+ID4gPiByZXN1bWUuDQo+
ID4gT2suDQo+ID4gDQo+ID4gPiA+IGUuZy4gc29tZSBxdWVzdGlvbnM6DQo+ID4gPiA+IFdobyBo
YW5kbGVzIHRoZSB3YWtpbmcgdXAgb2YgdGhlIGNvbnRyb2xsZXI/IElzIGl0IHRoZSBwaHkgZHJp
dmVyPyBJcw0KPiA+ID4gPiB0aGUgcGh5IGRyaXZlciBub3QgZGV0ZWN0aW5nIGEgcmVzdW1lPyBP
ciBkaWQgdGhlIHJlc3VtZSBmYWlsPyBEb2VzIHRoaXMNCj4gPiA+ID4gb2NjdXIgY29uc2lzdGVu
dGx5Pw0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBUaGluaA0KPiA+ID4gVGhp
cyBpc3N1ZSBvY2N1cnMgb2NjYXNpb25hbGx5IG9uIFJLMzU2MiBFVkIgd2l0aCBUeXBlLUMgVVNC
LCBhbmQgZW5hYmxlDQo+ID4gPiBhdXRvc3VzcGVuZCBmb3IgZHdjMyBjb250cm9sbGVyLg0KPiA+
ID4gDQo+ID4gPiBIZXJlIGlzIHRoZSB0ZXN0IHN0ZXBzOg0KPiA+ID4gDQo+ID4gPiAxLiBQb3dl
ciBvbiB0aGUgUkszNTYyIEVWQiBhbmQgdGhlIFR5cGUtQyBVU0IgaW50ZXJmYWNlIGlzIGluIHVu
Y29ubmVjdGVkDQo+ID4gPiBzdGF0ZS4NCj4gPiA+IA0KPiA+ID4gMi4gTWFrZXN1cmUgdGhlIGR3
YzMgY29udHJvbGxlciBlbnRlciBydW50aW1lIHN1c3BlbmQsIGFuZCBpdHMgcG93ZXIgZG9tYWlu
DQo+ID4gPiBpcyBkaXNhYmxlZC4NCj4gPiA+IA0KPiA+ID4gMy4gRG8gc3lzdGVtIHN1c3BlbmQv
cmVzdW1lIHN0cmVzcyB0ZXN0Lg0KPiA+ID4gDQo+ID4gPiA0LiBUaGUgaXNzdWUgb2NjdXJzIG9j
Y2FzaW9uYWxsecKgIHdpdGggdGhlIGZvbGxvd2luZyBsb2c6DQo+ID4gPiANCj4gPiA+IFvCoCAy
NTEuNjgxMDkxXVsgVDQzMzFdIFBNOiBzdXNwZW5kIGVudHJ5IChkZWVwKQ0KPiA+ID4gW8KgIDI1
MS43Nzg5NzVdWyBUNDMzMV0gRmlsZXN5c3RlbXMgc3luYzogMC4wOTcgc2Vjb25kcw0KPiA+ID4g
W8KgIDI1MS43NzkwMjVdWyBUNDMzMV0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgLi4u
IChlbGFwc2VkIDAuMDA1DQo+ID4gPiBzZWNvbmRzKSBkb25lLg0KPiA+ID4gW8KgIDI1MS43ODQ4
MTldWyBUNDMzMV0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4gPiA+IFvCoCAyNTEuNzg0ODUxXVsg
VDQzMzFdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgLi4uIChlbGFwc2VkIDAu
MDA0DQo+ID4gPiBzZWNvbmRzKSBkb25lLg0KPiA+ID4gW8KgIDI1MS43OTI3MTldW8KgIFQ1MDNd
IFtTS1dJRkkgREJHXSBza3dfc3VzcGVuZDogV29XOiBlbmFibGVkLCBza3cgZmxhZ3M6DQo+ID4g
PiAweDMwMg0KPiA+ID4gW8KgIDI1MS44MDM3MDFdWyBUNDMzMV0gUE06IGRwbV9ydW5fY2FsbGJh
Y2soKToNCj4gPiA+IHBsYXRmb3JtX3BtX3N1c3BlbmQuY2ZpX2p0KzB4MC8weDggcmV0dXJucyAt
MTYNCj4gPiA+IFvCoCAyNTEuODAzNzc5XVvCoMKgIFQ3NV0gUE06IFBNOiBQZW5kaW5nIFdha2V1
cCBTb3VyY2VzOiBhbGFybXRpbWVyLjAuYXV0bw0KPiA+ID4gW8KgIDI1MS44MDM3ODldWyBUNDMz
MV0gUE06IERldmljZSBhbGFybXRpbWVyLjAuYQ0KPiA+ID4gW8KgIDI1MS44MDM5MjhdWyBUNDMz
MV0gUE06IFNvbWUgZGV2aWNlcyBmYWlsZWQgdG8gc3VzcGVuZCwgb3IgZWFybHkgd2FrZQ0KPiA+
ID4gZXZlbnQgZGV0ZWN0ZWQNCj4gPiA+IFvCoCAyNTEuODA0MTQxXVvCoMKgIFQ3NV0gW1NLV0lG
SSBEQkddIHNrd19yZXN1bWU6IHNrdyBmbGFnczogMHgzMDANCj4gPiA+IFvCoCAyNTEuODA0NzE1
XVvCoMKgwqAgQzJdIFNFcnJvciBJbnRlcnJ1cHQgb24gQ1BVMiwgY29kZSAweGJmMDAwMDAwIC0t
IFNFcnJvcg0KPiA+ID4gW8KgIDI1MS44MDQ3MjVdW8KgwqDCoCBDMl0gQ1BVOiAyIFBJRDogNDMz
MSBDb21tOiBiaW5kZXI6MjUxXzQgVGFpbnRlZDogRw0KPiA+ID4gV0PCoCBFIDUuMTAuMTU3LWFu
ZHJvaWQxMy00LTAwMDA2LWc3M2YzMzc4MDRmYmMtYWI5ODgxNzY5ICMxDQo+ID4gPiBbwqAgMjUx
LjgwNDczMl1bwqDCoMKgIEMyXSBIYXJkd2FyZSBuYW1lOiBSb2NrY2hpcCBSSzM1NjIgUks4MTcg
VEFCTEVUIExQNCBCb2FyZA0KPiA+ID4gKERUKQ0KPiA+ID4gW8KgIDI1MS44MDQ3MzhdW8KgwqDC
oCBDMl0gcHN0YXRlOiA4MDQwMDAwNSAoTnpjdiBkYWlmICtQQU4gLVVBTyAtVENPIEJUWVBFPS0t
KQ0KPiA+ID4gW8KgIDI1MS44MDQ3NDNdW8KgwqDCoCBDMl0gcGMgOiBlbDFfYWJvcnQrMHg0MC8w
eDY4DQo+ID4gPiBbwqAgMjUxLjgwNDc0OF1bwqDCoMKgIEMyXSBsciA6IGVsMV9hYm9ydCsweDI4
LzB4NjgNCj4gPiA+IA0KPiA+ID4gLi4uLi4uDQo+ID4gPiANCj4gPiA+IFvCoCAyNTEuODA0OTY1
XVvCoMKgwqAgQzJdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBc3luY2hyb25vdXMgU0Vy
cm9yDQo+ID4gPiBJbnRlcnJ1cHQNCj4gPiA+IFvCoCAyNTEuODA0OTc0XVvCoMKgwqAgQzJdIENQ
VTogMiBQSUQ6IDQzMzEgQ29tbTogYmluZGVyOjI1MV80IFRhaW50ZWQ6IEcNCj4gPiA+IFdDwqAg
RSA1LjEwLjE1Ny1hbmRyb2lkMTMtNC0wMDAwNi1nNzNmMzM3ODA0ZmJjLWFiOTg4MTc2OSAjMQ0K
PiA+ID4gW8KgIDI1MS44MDQ5ODBdW8KgwqDCoCBDMl0gSGFyZHdhcmUgbmFtZTogUm9ja2NoaXAg
UkszNTYyIFJLODE3IFRBQkxFVCBMUDQgQm9hcmQNCj4gPiA+IChEVCkNCj4gPiA+IFvCoCAyNTEu
ODA0OTg0XVvCoMKgwqAgQzJdIENhbGwgdHJhY2U6DQo+ID4gPiBbwqAgMjUxLjgwNDk5MF1bwqDC
oMKgIEMyXcKgIGR1bXBfYmFja3RyYWNlLmNmaV9qdCsweDAvMHg4DQo+ID4gPiBbwqAgMjUxLjgw
NDk5NV1bwqDCoMKgIEMyXcKgIGR1bXBfc3RhY2tfbHZsKzB4YzAvMHgxM2MNCj4gPiA+IFvCoCAy
NTEuODA1MDAwXVvCoMKgwqAgQzJdwqAgcGFuaWMrMHgxNzQvMHg0NjgNCj4gPiA+IFvCoCAyNTEu
ODA1MDA2XVvCoMKgwqAgQzJdwqAgYXJtNjRfc2Vycm9yX3BhbmljKzB4MWIwLzB4MjAwDQo+ID4g
PiBbwqAgMjUxLjgwNTAxMF1bwqDCoMKgIEMyXcKgIGRvX3NlcnJvcisweDE4NC8weDFlNA0KPiA+
ID4gW8KgIDI1MS44MDUwMTZdW8KgwqDCoCBDMl3CoCBlbDFfZXJyb3IrMHg5NC8weDExOA0KPiA+
ID4gW8KgIDI1MS44MDUwMjBdW8KgwqDCoCBDMl3CoCBlbDFfYWJvcnQrMHg0MC8weDY4DQo+ID4g
PiBbwqAgMjUxLjgwNTAyNl1bwqDCoMKgIEMyXcKgIGVsMV9zeW5jX2hhbmRsZXIrMHg1OC8weDg4
DQo+ID4gPiBbwqAgMjUxLjgwNTAzMV1bwqDCoMKgIEMyXcKgIGVsMV9zeW5jKzB4OGMvMHgxNDAN
Cj4gPiA+IFvCoCAyNTEuODA1MDM1XVvCoMKgwqAgQzJdwqAgZHdjM19yZWFkbCsweDMwLzB4MWEw
DQo+ID4gPiBbwqAgMjUxLjgwNTA0MF1bwqDCoMKgIEMyXcKgIGR3YzNfcGh5X3NldHVwKzB4Mzgv
MHg1MTANCj4gPiA+IFvCoCAyNTEuODA1MDQ1XVvCoMKgwqAgQzJdwqAgZHdjM19jb3JlX2luaXQr
MHg2OC8weGNkNA0KPiA+ID4gW8KgIDI1MS44MDUwNTFdW8KgwqDCoCBDMl3CoCBkd2MzX2NvcmVf
aW5pdF9mb3JfcmVzdW1lKzB4MTBjLzB4MjVjDQo+ID4gPiBbwqAgMjUxLjgwNTA1Nl1bwqDCoMKg
IEMyXcKgIGR3YzNfcmVzdW1lX2NvbW1vbisweDQ0LzB4M2QwDQo+ID4gPiBbwqAgMjUxLjgwNTA2
MV1bwqDCoMKgIEMyXcKgIGR3YzNfcmVzdW1lKzB4NWMvMHhiOA0KPiA+ID4gW8KgIDI1MS44MDUw
NjddW8KgwqDCoCBDMl3CoCBkcG1fcnVuX2NhbGxiYWNrKzB4NzAvMHg0ODgNCj4gPiA+IFvCoCAy
NTEuODA1MDcxXVvCoMKgwqAgQzJdwqAgZGV2aWNlX3Jlc3VtZSsweDI1MC8weDJmOA0KPiA+ID4g
W8KgIDI1MS44MDUwNzddW8KgwqDCoCBDMl3CoCBkcG1fcmVzdW1lKzB4MjU4LzB4OWRjDQo+ID4g
PiBbwqAgMjUxLjgwNTA4Ml1bwqDCoMKgIEMyXcKgIHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIr
MHg4NTAvMHhjYWMNCj4gPiA+IA0KPiA+ID4gSW4gdGhpcyBjYXNlLCBkdXJpbmcgc3VzcGVuZCBw
cm9jZXNzLCBiZWNhdXNlIHRoZSBkZXZpY2UgYWxhcm10aW1lciBmYWlsZWQNCj4gPiA+IHRvIHN1
c3BlbmQsIGl0IGJyZWFrIHRoZSBzeXN0ZW0gc3VzcGVuZCBpbiB0aGUgZnVuY2l0b24NCj4gPiA+
IHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIoKSwgYW5kIGdvdG8gcGxhdGZvcm1fcmVjb3Zlcigp
IGRpcmVjdGx5IHdpdGhvdXQNCj4gPiA+IGVuYWJsZSB0aGUgcG93ZXIgZG9tYWluIG9mIHRoZSBj
b250cm9sbGVyLCB0aGVuIHRyaWdnZXIgdGhlIEtlcm5lbCBwYW5pYyBpbg0KPiA+ID4gZHdjM19y
ZXN1bWUoKS4NCj4gPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIGRldGFpbHMuDQo+ID4gDQo+ID4g
PiBGb3IgYSBjb21wYXJpc29uLCBpbiB0aGUgbm9ybWFsIGNhc2UsIGlmIHRoZSBzeXN0ZW0gZW50
ZXIgc3VzcGVuZCBub3JtYWxseSwNCj4gPiA+IGFuZCBhZnRlciB0aGUgc3lzdGVtIHdha2V1cCwg
dGhlIHBvd2VyIGRvbWFpbiBvZiB0aGUgY29udHJvbGxlciB3aWxsIGJlDQo+ID4gPiBlbmFibGUg
YnkgdGhlIGZyYW1ld29yayBvZsKgIHRoZSBwbSBnZW5lcmljIGRvbWFpbiBiZWZvcmUgZHdjMyBy
ZXN1bWUuDQo+ID4gPiANCj4gPiA+IFRoZSBmdW5jdGlvbiBjYWxsIHN0YWNrIGxpa2UgdGhpczoN
Cj4gPiA+IA0KPiA+ID4gc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlciAtLT4NCj4gPiA+IA0KPiA+
ID4gIMKgwqDCoCBzdXNwZW5kX2VudGVyIC0tPg0KPiA+ID4gDQo+ID4gPiAgwqDCoMKgIMKgwqAg
wqAgZHBtX3Jlc3VtZV9ub2lycSAtLT4gZHBtX25vaXJxX3Jlc3VtZV9kZXZpY2VzIC0tPg0KPiA+
ID4gZGV2aWNlX3Jlc3VtZV9ub2lycSAtLT4gZ2VucGRfcmVzdW1lX25vaXJxIC0tPiByb2NrY2hp
cF9wZF9wb3dlciDvvIhlbmFibGUNCj4gPiA+IHRoZSBwb3dlciBkb21haW4gb2YgdGhlIGNvbnRy
b2xsZXLvvIkNCj4gPiA+IA0KPiA+ID4gIMKgwqDCoCBkcG1fcmVzdW1lX2VuZCAtLT4NCj4gPiA+
IA0KPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqAgZHBtX3Jlc3VtZSAtLT4gZGV2aWNlX3Jlc3VtZSAt
LT4gZHBtX3J1bl9jYWxsYmFjayAtLT4gZHdjM19yZXN1bWUNCj4gPiA+IChhY2Nlc3MgdGhlIGNv
bnRyb2xsZXIgc2FmZWx5KQ0KPiA+ID4gDQo+ID4gPiAgwqDCoMKgwqDCoMKgIMKgIGRwbV9jb21w
bGV0ZSAtLT4gZ2VucGRfY29tcGxldGUgLS0+IGdlbnBkX3F1ZXVlX3Bvd2VyX29mZl93b3JrDQo+
ID4gPiANCj4gPiA+IHN1c3BlbmRfZmluaXNoIC0tPiBzdXNwZW5kX3RoYXdfcHJvY2Vzc2VzIC0t
PiBnZW5wZF9wb3dlcl9vZmZfd29ya19mbiAtLT4NCj4gPiA+IChkaWFibGUgdGhlIHBvd2VyIGRv
bWFpbiBvZiB0aGUgY29udHJvbGxlciB0byBtYWludGFpbiB0aGUgb3JpZ2luYWwgcnVudGltZQ0K
PiA+ID4gc3VzcGVuZCBzdGF0ZSkNCj4gPiA+IA0KPiA+IEF0IHdoYXQgc3RlcCBkbyB3ZSByZXN0
b3JlIHRoZSBwb3dlciBkb21haW4gd2hlbiB0aGlzIGhhcHBlbj8gTG9va3MgbGlrZQ0KPiA+IHRo
ZXJlJ3MgYSBtaXNzaW5nIHN0ZXAgaW4gdGhlIHN1c3BlbmQgZmFpbHVyZSByZWNvdmVyeSB0byBy
ZWNvdmVyIHRoZQ0KPiA+IHBvd2VyIGRvbWFpbi4gV2hhdCB3ZSdyZSBkb2luZyBoZXJlIHNlZW1z
IG1vcmUgbGlrZSBhIHdvcmthcm91bmQgdG8NCj4gPiB0aGF0LCB3aGljaCB1bmZvcnR1bmF0ZWx5
IG1ha2VzIHRoZSBjb2RlIGxvZ2ljIGxvb2tzIHVuY2xlYXIgSU1PLg0KPiANCj4gV2hlbiB0aGVu
IHN1c3BlbmQgc3VjY2Vzc2Z1bCwgdGhlIHBvd2VyIGZyYW1ld29yayBjYWxsIGRwbV9yZXN1bWVf
bm9pcnEoKSB0bw0KPiBlbmFibGUgb24gdGhlIHBvd2VyIGRvbWFpbiBhbmQgdGhlbiBjYWxsIGRw
bV9jb21wbGV0ZSgpIC0+DQo+IGdlbnBkX3Bvd2VyX29mZl93b3JrX2ZuKCkgdG8gcmVzdG9yZSB0
aGUgb3JpZ2luYWwgcG93ZXIgZG9tYWluIHN0YXRlLg0KPiANCj4gV2hlbiB0aGUgc3VzcGVuZCBm
YWlsdXJlIGhhcHBlbnPvvIxpdCBzZWVtcyB0aGF0IG5vYm9keSByZWNvdmVyIHRoZSBwb3dlcg0K
PiBkb21haW4gaW4gdGhlIHBvd2VyIGZyYW1ld29yayBhbmQgcm9ja2NoaXAgcGxhdGZvcm0gcG1f
ZG9tYWlucyBkcml2ZXIuDQo+IA0KPiA+IA0KPiA+IENhbiB0aGlzIGJlIGZpeGVkIGluIHRoZSBs
b3dlciBsYXllcj8NCj4gDQo+IEZvciB0aGUgdGltZSBiZWluZywgSSBoYXZlbid0IGZvdW5kIGEg
c29sdXRpb24gaW4gdGhlIGxvd2VyIGxheWVyIHRvIGZpeA0KPiB0aGlzIGlzc3VlLiBJIGhhdmUg
dG8gZGlzYWJsZSB0aGUgZHdjMyBydW50aW1lIGZlYXR1cmUgb24gUkszNTYyIEdLSQ0KPiBwcm9q
ZWN0Lg0KPiANCg0KV2hpbGUgdGhpcyBwYXRjaCBtYXkgYXZvaWQgdGhlIGtlcm5lbCBwYW5pYywg
YnV0IGl0J3Mgbm90IGZpeGluZyB0aGUNCnJlYWwgaXNzdWUgaGVyZS4gSSB0aGluayB3ZSBuZWVk
IHRvIGxvb2sgaW50byBlbmhhbmNpbmcgdGhlIHN1c3BlbmQNCmZhaWx1cmUgcmVjb3ZlcnkgaW5z
dGVhZC4NCg0KVGhhbmtzLA0KVGhpbmg=
