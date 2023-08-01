Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D413076C147
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHAX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAX4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:56:43 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C571BD;
        Tue,  1 Aug 2023 16:56:42 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Nnot4024206;
        Tue, 1 Aug 2023 16:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Tge+1A2BWQqu7vx9TOZ1YB1ZwjEcPZxOT5lM7jS+8t0=;
 b=aK8KULG2hYD02Sqj93lvoI5WRqcF49oyqeojQ/QeJszNEp4l8z+5CoZNtR4gKi3r46TA
 NM0gDINk1X1ddOjlNM1R7sLND6NhrgOPNpVBDx7GIhdwOLtnpzMCqNgjwI2KhIiJBbSE
 mpihtZXkvnYUK4hHlGC+7mkuZoodiZrqwzyl1VfVtcB6F4ANruKuzCuXhOv41wXPZATg
 u14e3kWUakb5JUieK2UK1bbsBbqP5uymdL1eOfNsaxTa9aLmEYxylYB+Ea9nzAIyu05f
 ywmF+A99N8jQaCC1ur/SoNRBVusMQ0/WPr31SFSosDfYc1MpBq92Pmt71hMc551XXxiP 9A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51psym41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 16:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690934193; bh=Tge+1A2BWQqu7vx9TOZ1YB1ZwjEcPZxOT5lM7jS+8t0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=I7uY45VhuG1bAVYkD+6xHQKf10bgl4J//O01Fgfrc4MtgDo27sHyBueD0Uta5tjV1
         Z9SkOKyr/J9zprzAlanw39cMrSAmgeTuNQ7xBv6Mp9FCZGsS0pzPwk+vUy3RpFKa6x
         OEcZ7YCOwaAbzEMC7j1Aklu0zAcd5dqr+In9yeuQNSvgHgKAIjT/mnoGpMJzz1PsXS
         +SHQ1JQssfRpm7XRNFZbaHd4wSKywOZBImKyP6jDNhOGunCP3NDrBwi0ASVDzKSoOI
         PScGQSVQXQqxi2bVz4QGTW1AP9DF4oL87hlZ0CZ8ZpM7ycnBE/sAX6PQXJNontQ2QA
         mS7EVIcm6sIbQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 91CBB40351;
        Tue,  1 Aug 2023 23:56:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 228F8A0085;
        Tue,  1 Aug 2023 23:56:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cXDR3FTb;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 179BB40565;
        Tue,  1 Aug 2023 23:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGCFwXw4LwEK/4hUD+0KQNbI78RotZruOVLq6YQWQTuUqHtmR7Feh8cwZcB4Aew6V4tdAHBENhpFdxkQvB45GxNCOnJI90dQ8dFWgpR/dGFDsXrnHCD95XdlkAj9LYHxKXOEaQ/lQnZWPmF7WBTWJ/UYJ20sd4+Kot1b3Xx96P9c3BhS3PpKDkm1A47FM1Gmfl2cxtcX8KVqCf8cr5/H+6DIgtSWq1HKvfW+uHzw4reTMrFZq/oGhjbCmWV8/9WG7OStloggs/MFRnbLdD8sWW/6vvYCZM3tijoH9fjIBtKbLjJsoQ2QENVl1BpQWwR2orAQjLh4oVQlLhgmSSP8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tge+1A2BWQqu7vx9TOZ1YB1ZwjEcPZxOT5lM7jS+8t0=;
 b=JxsP4zFqrgZk9MTqOhMP6mMM9sZG263CAvdG+u1aRSIynDU0QpAEzm4/f341a0n3lVIJr+pYqRvE4jMkj5aCS8EsiyrHqvCwi/aBupuCxrloySYRAn+g4cVh6QK6xBI7DXmxI4sGWv/zfITN74ls/nr3FeFSYzkkTGbDwn82knunx3In6ed2DUWKjjnVkYSu5avaE7exWP782ZjTH9T95DOVda1j6sHoW/eksnxye7dagVshQWm+Tr9taw/X4moPvnDTy96iMKeMZeYrFKrutqZyCX/GljMURIa2S1CTCssQzLD2tLTgC3RAVaR9uv30m31mplrvpS3yjpIitIP+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tge+1A2BWQqu7vx9TOZ1YB1ZwjEcPZxOT5lM7jS+8t0=;
 b=cXDR3FTbcNdJVt0dDm9X/kiVd7JQCr/t/5Fd6KJggeHbRk7lA/ZrOrZfg+iNThKZSvRTQLD0NKvaiJPHR42qsK66Il12+bT4QckyAxgIjIC8i6yOwA/rOnuNTJSUJ6bYaJM2QozuTDg3SiNLKFdyLWwt8Zi0wd4SU9bbYKXSDWE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 23:56:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::588e:6476:a6eb:d698]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::588e:6476:a6eb:d698%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 23:56:26 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Surong Pang <surong.pang@unisoc.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Orson.Zhai@unisoc.com" <Orson.Zhai@unisoc.com>,
        "Chunyan.Zhang@unisoc.com" <Chunyan.Zhang@unisoc.com>,
        "Zhiyong.liu@unisoc.com" <Zhiyong.liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Topic: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Index: AQHZw1eMAo0F1UevnEeZ1ZzK9omr8q/UnVeAgABBz4CAAUGvAA==
Date:   Tue, 1 Aug 2023 23:56:26 +0000
Message-ID: <20230801235616.i2k4rq4xroesuwbf@synopsys.com>
References: <20230731023323.16046-1-surong.pang@unisoc.com>
 <20230801004923.mcmkgoliy2qlwtah@synopsys.com>
 <2023080139-treason-emboss-75be@gregkh>
In-Reply-To: <2023080139-treason-emboss-75be@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB8173:EE_
x-ms-office365-filtering-correlation-id: bbddd0bf-2d80-442e-dec4-08db92eaead1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJtNK89Kyr8xQdPPY3AQvJdCr18Fwd+pyh1CqyoFfBhKHwwNJqMOuSopUtPjTd4h6q+9XAdpswbhAkwAdzAlUiXrelu/nkn5Ys0zH62pbdtyYyJDBqrfIjmjQ5ZFIb8MifsJtuTkMXLeabh3nAzSEaQjTtehUoGYKtHvhwzCJwzSpQg5GtYD/gUoD1wAOQzlIpDoJvBwgmIoc0fmw1DtXc6i0OrAjoto6+TaRUIJkJ0+pMfc2iZb/TPPhm9rNYRL0u4AAJbK3c6kVfXjOjZcwGy45u69kTzR+w5jeLo5NRFGSD714CE7osXD3/FE8MPllEJhw4BIDyxfL3YYjvy9G10UCPWXtwq1al++6NM4kKEqaAf9rZviZa7+fIO6aMjD1FIpchLUaCA/cz/6Xma/yYliveKQb4hWLuL/Lxw73ie5zRHa4Q6wAGAJLj89KeMxHSYkvm9++bor9oN3tISILMLgUgIDYqDD0SmqteRJLuy0YVVvcW2V9Rw1DzoC5Mde9IYHXArLEY/vkiq52PIlVewz+7rNTSzC06BY6BeC6gTmF8/v8KU3+9RHAGGcy3M7WHNi5fj4XxJ1HxvDykva0wGkfaSDDKo7V21odTvsuTWVgzjRy4yZV00QZs9fujPi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(66556008)(66476007)(4744005)(66946007)(6916009)(66446008)(4326008)(91956017)(64756008)(5660300002)(76116006)(54906003)(2906002)(316002)(478600001)(41300700001)(6486002)(2616005)(71200400001)(8676002)(6506007)(1076003)(186003)(8936002)(26005)(83380400001)(122000001)(36756003)(38100700002)(38070700005)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9ZR3kzVDNMOGlROXQvQW9lK29xbGhxTW54TjQyMlhZTkM2ak8xVGova1NJ?=
 =?utf-8?B?bERscVRGVmIxdjlNRjU2Y1VMdG5xUlJnU2lIUmtycHVtQS9JMnEzd0QveG95?=
 =?utf-8?B?Ui9jSGZ2SlZPZzEwUjVNS2FlaFN1RW96aDcybGRmekNtNlYvcTZRQkJuWitY?=
 =?utf-8?B?N3p6VnY3Rjh1c1ZTeVRrRW1sOVFvSnNxcUM1R28zYlhUYkVWWDN0Z0NQMnND?=
 =?utf-8?B?RFphaEVsWEtqU2p3SkpIYUhRcUFDM29WVzh5ZUxLRWNWSGtxa0t1aGs5Y1VE?=
 =?utf-8?B?WjlLMldZSUtxaTNSdjZWMWc4YzFxa0I4L09ZZlpUZlQ3T2xhM1FERER1bzd2?=
 =?utf-8?B?VGthdFFkQ1JZR29ySmZGOWNVaHcrSnltR05TUWhaelUvdEE3aXBmN25UUTVR?=
 =?utf-8?B?QjF1bUczK3E4Q3NzOTl3dEU4bVluQitFSHptdVdIMk9UeEtyTWsrSzdnZnI2?=
 =?utf-8?B?aTZWbWhtbkJyeUMzamR0UWduTkw3em9WV05PdVJoWTRNR1F2Y3lSUlNwRU1P?=
 =?utf-8?B?K0dzK2dtSld5VGJQbTQ5ZEZHdS95eG1sb0NUNU9RR1dTL3ExY1dIdy9yVjlt?=
 =?utf-8?B?YmJkd2VOUWg0MUhGWmJQWmtuMnFnZ01NM0ZNQXpSQ0Y0aTZxSnFOeDBZYk9o?=
 =?utf-8?B?WWhEOXRnY1RvMko2S2ZoOGJzMGc0UURpVTI3a2dNa2U2YmUrRnFjb1lNbkIx?=
 =?utf-8?B?U2JNa0toWUhoSUhQU0doN0ZEWXhNbjc2MUN0RCtGOFlwa2ZMN2pNb3JJR0M4?=
 =?utf-8?B?V0R4RTdJVGNHNWRCL3RjeFJScGlZbHhkbXFMakc5MkNUc212b1FQQzR4TnJK?=
 =?utf-8?B?bktFdklBYUVFTU5sdWJJOWU0OUVJdFF2SE1wVTNYY01XRjRtMERwYTlaNG5R?=
 =?utf-8?B?Zlpxa1YyVVZOdjBzOVRBcEc1TzZoUWVodHhWRWcwUHFxNUZpdkJ4MEhZU0Zv?=
 =?utf-8?B?Y1BXalAzSCtLMDY5WG1RU2hRYURIblA0dUVrV1NqT0g3ZjRIUXlhNGVxblRW?=
 =?utf-8?B?WXFBN3ZZSjNsVjlPZURiUWFRM09hNFA5MG1aZmFRaVNBUlJaUjlPYTloYTFK?=
 =?utf-8?B?UkNkV1ZOMUJ3L1dTNk8zQ1c1TFVSYzBuUFBMNTNHTDNsNHhDQXJUQTl0RTdX?=
 =?utf-8?B?bW9MTDd6Z2kvdnJlNiszbWcxNmVvcHphbTFBSlVsNERyOEFVc3pCOHN1RHVS?=
 =?utf-8?B?NTd1NjNsS1Y4T0Y5WDc5VE9lWE90Ukh3NGluNGNhV0t0a2plS0g3ZURjRlpU?=
 =?utf-8?B?NTA5akd1aE1ST2V5dU1Rd3ptajcxd2RNeUg2UC9GMytoUGhDQlFwVllKMTZZ?=
 =?utf-8?B?VGJIMU9McHZVam5GUVJuVEZuMDFPeGsraEYrUXBnZ2NCQmNBMTlOQzRiVFho?=
 =?utf-8?B?ZVFCeFhoc0RMc2dmRzlsQjh0ZkJtaDZoVXpMUkI4dkhLYTBBWVRwQWI4eUds?=
 =?utf-8?B?N081TVllQ0lHTW5aZ0VkZm1TelpDTGtqdEtxQzhaek5NU1JkMHZSVTR3cU5o?=
 =?utf-8?B?TkhmQ052UldJSlovRTZPckE2TzVuTmExVVg4anhRQUVkRk9BcUZvTjY0UEdN?=
 =?utf-8?B?amtJK0JHR3dvT3JqU01Kcmw1Y3VudmRXMnhRcDdXTXJIVWY0QVdUaUcrZC8r?=
 =?utf-8?B?c2M2NkNQdWJoK0N5VG16UG9xOXFSc2tqSENnaWNBME1EY1pUSGpyaFM0YTU3?=
 =?utf-8?B?RzJGcE9GRjlVRkxXdDhBZ2FyQnVycTM1Mk16WFYwbk5ReXVNMERhSXJkelk0?=
 =?utf-8?B?amM3NjhibEd3QXNVMDJpRkZ4WHJ2VlBsZk4xNndOcEhuandESFFjbk94M3Jx?=
 =?utf-8?B?K3gzS3A2SzMvUXVIdUcrdkQ4bkt4VTZ3U01qMDFmS3l4emtkWFpxYVRFUEVu?=
 =?utf-8?B?VVFSS1BZZVJFckhPQ1pEYzU0SWpjMWdTeDE0Q3N5SllxYStPbURXSUJ1OFlp?=
 =?utf-8?B?M0E1RTJRYThBaTVoV1RUdEdlT1NXSGJLS2dKSWRMa28yNVdPbmVlNXhyN2w5?=
 =?utf-8?B?MGh2emI4Q0xVdzg2TlhBeC96OWdNSis5WENPMGp0aDBXTzdWcnpmUVQzMU94?=
 =?utf-8?B?UHB6R1Y0cS9lbUpPNWFzb3lKYzdjenZvVjhtUWlTUnFOUkJvQVY1MDAwUnd3?=
 =?utf-8?B?U0dxMTNJQm1sVDFEUmZhZEFSditUK3dLd3h0ekNnOU5lOU85ajBZaWhyYmlS?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1262624DBF9E1D459D4AB5A4C4E44EF7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0VZcmNCeEFIUkNNaUV4aFVZc1JkV21MbXgvODNjNndLNHZlNDFKOXRuUFR5?=
 =?utf-8?B?Yk9XK2g3UW1pdmxDdldOcDRiWjBMRndGZEx5NkN6Ly9hdEVRaEhlLzRBZ3lh?=
 =?utf-8?B?WkN0T3YrS3lqRnNoOHRYazlyTjlCeVFhRC9WUll0NHFiRmRyT2ZZYzlSVzds?=
 =?utf-8?B?cTNSdkFwQy8rRHZnd2UxWnUyRHhNbmp5VFQxOTNqcUcyeVpOS0xDOEp0dmNW?=
 =?utf-8?B?ZnVzMWJDTjlqUVg4WWlRVjRNSjdiK3o2RDFxUWM5djdrOGJTN0VaZmNRM2ds?=
 =?utf-8?B?eHFzOThhWkJHa3hrVFdYdDk1MTU2dWdFU05CL2JvQmVrcHVQS1ZBN0FzMkox?=
 =?utf-8?B?TmZUWmc0ZCt1eFFOYXI1cVphYWd4OE0rcFdEaWlubHNUTXhGZzdjSWxrRHVB?=
 =?utf-8?B?WjdhK25lM2pGTksxc09zT1libXk4Z0h1Y3l1UWxzMGg3am1zM1dXKzNXbDAy?=
 =?utf-8?B?MmRPZGVWTmdwd1paMzByOVV6aE8wZDlpc3hhN2VpYnhkdEd3RXFPMFBiVk5j?=
 =?utf-8?B?K1NXV2hSOFF3ZE1PL3h4dnhjWStSRDBKd0lBRy9JVEJHV3NPK0hrY3VvejJt?=
 =?utf-8?B?dzEwcURtM0VNZlRRQ3dNRFRJUW92T1l2dElQZmIrYm53RlJOazlvNVAwSjlr?=
 =?utf-8?B?MC9WSHhZMnJoZGhYcHBLUTArSEtxSUJKanNrK2JCeUNsTUtPbVNJWnB0VTlE?=
 =?utf-8?B?eW9hUlZwY2hKTUEzTnF3dExablMxSHpxWUt3YzBQemxmL2V2Q3NqZFlOeXYy?=
 =?utf-8?B?a3Rqa0lSRmJ4K0YzdytoMDgrWWxvTUdobVl0NGZCamorSE1xdEd3OFkwbSt4?=
 =?utf-8?B?TXltUzYvSDRoMzd0S1Q5Tk40YVd6cGwrVlYzNW9oMFozTWRGeXg3SU1YejZ0?=
 =?utf-8?B?Wmt2cHBrMUJlTGlXZStKN2pZR0RjMi8rTFhhSkNCZHNZUXAzNlV5K2pLcUVZ?=
 =?utf-8?B?VTd2MTNQNjZhQk5JQkJKengvdGlEV1A4UzVtR1BXWTRUaGFtajJTUGhJbDhJ?=
 =?utf-8?B?Vi9ZcnNMaGhPSjB1T2k2Njd1cXFsYWRYcER1OUtWb0dhOUczVUZMbmladWRq?=
 =?utf-8?B?RGJrWjB4MElubTVEZ2gweGNLRGlQNWphdGVuWTFQcUhPWFpXUVh0QS9uRzRm?=
 =?utf-8?B?T013clpmWk95Wm9QeVNXY21xamdLeDRIb3lXbDZXWWhkWEt0TVBhMUtsbFVK?=
 =?utf-8?B?bWNVbm5mT2lrdDg3NnF2dkl0amw2VFVMcGo2WitQQnpkaW4xVUxFWDJkaTZv?=
 =?utf-8?B?MTFDeDhGUW1ML2h6THJtbGZSbnRNWkMvMWV5N1liNTlvMHRyQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbddd0bf-2d80-442e-dec4-08db92eaead1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 23:56:26.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfKGku+ZOuQ9+d/gI+5YUiRDLhGH8vaoWu1Qcz8cJSr+qFJt6aE0ZJFJoAGfO0Zej/5LfOD/e9a8L3S1s2Ck4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
X-Proofpoint-ORIG-GUID: tZsmROE9WPHwqd3AtjIcy703TNK-9vQh
X-Proofpoint-GUID: tZsmROE9WPHwqd3AtjIcy703TNK-9vQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_20,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=696 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDEsIDIwMjMsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAwMSwgMjAyMyBhdCAxMjo0OToyNEFNICswMDAwLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gT24gTW9uLCBKdWwgMzEsIDIwMjMsIFN1cm9uZyBQ
YW5nIHdyb3RlOg0KPiA+ID4gUG1fcnVudGltZV9nZXQgaXMgY2FsbGVkIHdoZW4gc2V0dGluZyBw
ZW5kaW5nX2V2ZW50cyB0byB0cnVlLg0KPiA+ID4gUG1fcnVudGltZV9wdXQgaXMgbmVlZGVkIGZv
ciBwYWlyaW5nIHdpdGggcG1fcnVudGltZV9nZXQuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBmYzhi
YjkxYmM4M2VmICgidXNiOiBkd2MzOiBpbXBsZW1lbnQgcnVudGltZSBQTSIpDQo+ID4gDQo+ID4g
UGxlYXNlIGZpeCB5b3VyIEZpeGVzIHRhZy4gUnVuIGNoZWNrcGF0Y2gucGwgYmVmb3JlIHN1Ym1p
dC4NCj4gDQo+IEkgZG9uJ3Qgc2VlIHdoYXQncyB3cm9uZyB3aXRoIGl0LCBvbmUgZXh0cmEgY2hh
cmFjdGVyIGlzIGp1c3QgZmluZS4NCj4gDQoNClRoaXMgaW5jb25zaXN0ZW5jeSBidWdzIG1lIGEg
Yml0LiA6KQ0KDQpJdCdzIG5vdGVkIGluIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiB0aGF0IGl0
IHNob3VsZCBiZSB0YWdnZWQgd2l0aCB0aGUNCmZpcnN0IDEyIGNoYXIgb2YgdGhlIGNvbW1pdCBp
ZCwgYW5kIHRoZSBjaGVja3BhdGNoIGFsc28gY29tcGxhaW50cyB3aGVuDQppdCdzIG5vdC4NCg0K
SnVzdCB0cnlpbmcgdG8gYmUgY29uc2lzdGVudCBhbmQgcmVxdWVzdCB0byBydW4gZm9yIGNoZWNr
cGF0Y2ggYW5kIGZpeA0KdGhlc2UgdGhpbmdzLiBJZiB0aGVzZSBpc3N1ZXMgc2hvdWxkIGJlIGln
bm9yZWQsIEknbGwga2VlcCBpdCBpbiBtaW5kLi4uDQoNCkJSLA0KVGhpbmg=
