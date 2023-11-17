Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703397EEB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjKQD25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:28:55 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D1A5;
        Thu, 16 Nov 2023 19:28:52 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH10Gpf010914;
        Thu, 16 Nov 2023 19:28:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=UqRVyDBv1AIrU8hkHtqurBJx4y4EK6srhDbLKgxP2+4=;
 b=LFaCehQYOGTPJH/jYY1y1Q8qUUi6IsaUX8Hvps24B1IYb5BAHvwgLyV159VNIefHMpPF
 7IpwZnPEcPG6T96yw9x6N5d80EIDTG8gjQvznkHVwOlnfkuWCVQfptlw3E2XnbIsgQaK
 9IHgnxLHt+0/iv2/7SyRNOm2lCz1C6F7IbW50VkJGxztL6DZYnuegdo6xAAQ/hOo5ouh
 /i3GKvr/d/p8dRXx4oUE+EytBn6I4knuUprrQS0vSmocquLd/up/8ZRcsJNWcEPz+Fck
 BD5Zaje2d/4XzWcsD2JjfLNrISYmJrykVPnGsCT8SswfdtTazRrwC24uPybjJWuS9epD ZA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ua94kaf6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 19:28:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700191724; bh=UqRVyDBv1AIrU8hkHtqurBJx4y4EK6srhDbLKgxP2+4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b0XhyNMKOVMBGry57Dvvh2266Uh6589lEDydLwm59N/vgtfCvOc778JHi74RQb7tS
         Esi3T3T7DfvnMFTnyy4flP3sGUzzZXknViI+INWjBF2r036tMd0l39Fcetr3LJ4dOd
         v/67yLIp5LSdIxdrpB8zSO58g5pws2CafcnJH81Hiqb/Xtc7gSDAnKNpzj62T3BQK3
         CLlKyU5lpOrtvSVjUEXhCfvv1G2PtIUy/4+vhJ3XHygu2QfGIiRhGdvp3nF3tXy87f
         8gLjEzVg3vjTBE82u07qMF3B88B9af0fY6OgkB5xNXJtKdfsRo4Jal1ncyyxrUSCWu
         jogu+VczsxByw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31B6D4011F;
        Fri, 17 Nov 2023 03:28:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C1993A00F4;
        Fri, 17 Nov 2023 03:28:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=raWc6IbJ;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 576A840529;
        Fri, 17 Nov 2023 03:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACmeSuFqfOC81UXxKhxMwR9hkXlb1JNOd8Pn7Ha75zDTsqtd9uyhqqqzmWosmcE+pLtkOClfEfQa43dnTthy0DYSkujUID7fE3CsnXgE6mWizlH/1GcbYmG8kyf6lmrxu7cFRyq3ncClnl0IbWl/beP9XfVSOiRMPVUNgr3Ei29z0efRj6TcElmWH3f3P7tap0+j8BgYdvpds2a9iKOPHMwooQt3eZNs1W9v4oFSYdUymlzETZt7K31n15bnqcRbAXoUa/xIQEaYKtHjrkrYA/Dm+BKiGon3Gyghp72ly4jz4l4TVY4Ksy+VGJZUaleOsgUIpWBbpS1nYQ4cjCV/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqRVyDBv1AIrU8hkHtqurBJx4y4EK6srhDbLKgxP2+4=;
 b=Kur0Ssguk7UrzX2pWSILwuezESsIE/raF86wHIm8O5iVkv2hDS6epKmLn8PLg6gnJnFW4jKxgRDnh8t4BW0ccUaDLb+9mjLb/VYcYfjzOmXTX9o/+JIYi1Lvrmj9BeN4okr29DDCGFgmSXm6r8d3sJzWapN0YCtXoGXh23pju2UX6wdRvOjZbJXu7kZT2EV98Qb36dQwsHRSQNbMEFSGTCn+jk1Z9mWEVpIkQkB9b3CnZB5JVo4VltESTH1Ii8uJTCO/oDh22PSOFYYnYRl2ZBxRMnLK00PIjj8PjjiCB8k6FHfP1MOOgdtjxDFEi/I5OJqVHmloaClLR0jIky8JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqRVyDBv1AIrU8hkHtqurBJx4y4EK6srhDbLKgxP2+4=;
 b=raWc6IbJLGOr/6o4bVHIOxmaur/xBdHseVad7i7z99wnVIwFdKTFmkK5GIP3+2IxopHyNFihQXrw16liH4ywC2Q8yaqcViFFfN0MfKij9zo206SM5NyW+hHzNbLNiPBHmkvCxQcQrY6mf+BSJJWPsaXjF5/6xf/D0Gj0s7O5tWU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 03:28:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 03:28:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Dan Scally <dan.scally@ideasonboard.com>
CC:     Kuen-Han Tsai <khtsai@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "piyush.mehta@amd.com" <piyush.mehta@amd.com>,
        "radhey.shyam.pandey@amd.com" <radhey.shyam.pandey@amd.com>,
        "siva.durga.prasad.paladugu@amd.com" 
        <siva.durga.prasad.paladugu@amd.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index: AQHaDVvtK46auOuFqk6xUT0xKW8RPLBm7bwAgAlqnQCADGtvAIABEQcAgAAcwAA=
Date:   Fri, 17 Nov 2023 03:28:40 +0000
Message-ID: <20231117032832.6k4msq2vlp56asho@synopsys.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
In-Reply-To: <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8410:EE_
x-ms-office365-filtering-correlation-id: 7cd19ddb-3a02-4aca-f181-08dbe71d4afa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5hFpO+EmP1vecYX9vsTR853t4u77WD0Ks4eXLhMlbwFdFgEMrzjE+45gSkzfwwU7PvE+jj2D/Mqr7L2mzQRSw3NZp4JZu9sHCEPBQ8vHP84hfh9h2TjLVRNdKXmMVWJgxtXt8mXUWyAsqN4e1XGwHoXT4d3LHB5FG6dQB7AWzFsLJN74bCZ7Qj7iZ9JGKsLx+47JOsw3LWePk+dEQwFtd5+YdMmopbEW0D0RAhhudsi/PRVwFNEI/m+lBRApWyX0UGfj351FxMvc8zjXL0umlaymg+SWYc5YCQLPApHDOJzgv9xfqJuHHFRzPn2V1FTKKPGSpxpHoaSvMgYeBGnHvtJWmRyrlZZ2IG/VCfijBzUOMEvdPYJiW6hyuowFewK/dto4MAzbKAUlFQrr1sCZf6yzIboS96DIWZSKBS3JUVv66o0OZkZmlXKKnclIPQzlHXgvQfNrxr5URHCzzJGx+0dSqwNkuboHCUt8CZb33zVZAjRTV0bLzL0ekuvtjsp1NlmQcHi7bSv3g89XqTFNDus6OKGr7HaHDDAj2p5qsfE99NHcxFCA6yPHDn+mkRbxq7xqW+XYFypchYiaa2e5Xamm4QHRtJ4hWNE3s8s+Mf6k6U/CQVSvV8DLWWLOLmS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(83380400001)(26005)(2616005)(1076003)(53546011)(71200400001)(6506007)(478600001)(6486002)(6512007)(54906003)(6916009)(64756008)(316002)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(4326008)(8676002)(8936002)(7416002)(86362001)(5660300002)(2906002)(122000001)(41300700001)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdTODBaa25rR3BCdzZ6eFdnNitpaXFZeWFMNGZDNWJkaWRKb0pNQ3RFdkky?=
 =?utf-8?B?dDhQenMvTld3OStKL29Pc3pOWld2Rk9FMXQ0eU5DMTh4amFsUjZ1VXl4NWFq?=
 =?utf-8?B?eXdIRGc5TVlPNFp0d2Z0TmJMNk9iSmhCL3RDblNaWmFZdEkxelZsU1ZXWkVx?=
 =?utf-8?B?UTFGUEpEbGhkQlRtTUFZK0lXZWJXdEdvTXdMb0NzUlhOcm8zNEtKZXBtbXhn?=
 =?utf-8?B?Vno4WGFYNy9CbTEzTDUwNExON0IwOGpOOHFIZTRPMERhWS9IWGdveWJpc2J0?=
 =?utf-8?B?aWZUK3NKak8xMjUxd3RMejVUaEY0YjVPT0wrN2QyNEMvdzJVZVVFSjAweGpU?=
 =?utf-8?B?RU1jdnJyTndudWhSOVlYNWd0MmI2Z1lCY3NWVUhMdUhUeGtmUXE4QjdFVlIw?=
 =?utf-8?B?UnB4WFRJaURSdGhCWXlVWFhjdXNZMno3eXJKUHBuSzBlVGxtM1BaS1h3NlJx?=
 =?utf-8?B?N2hRWmFFYWcwS0ZPY1FTdE5JdytCSkxtL2hxSGdvMktBcEh5cFlxSGpiS0hk?=
 =?utf-8?B?bVRSREZKV1U1alJhS2VGQUJnOXhkUmRyTWJ0em9sVitYc0t6d1lkR2NRUEx1?=
 =?utf-8?B?bTl1Tk1RV1VNWHU0NTdJWVRKK01iV3NIYmVTbWFpUFdWQVBIcGhoakNBMXFB?=
 =?utf-8?B?UVJUNFVzbklZLzIzTlI2OHo2MHNMeXg3WmlIVmV0N3B5STlkOEgwS0N3TXRk?=
 =?utf-8?B?eXZjcHBVd0VQRCtSc0VxR2U5anptSlNra3FTaEZQSDVQVUVhWE4zV0RmUTlO?=
 =?utf-8?B?VndaU0RHbFFGaFFmU1JOVkZlM2k0UE5TSHkvRW9OZ3RSazMwUXRzSVJsTUdy?=
 =?utf-8?B?bjMyakQ5SHY0MkxSRlh1dFlLRVcwa2thOFUwUWluWDNzaENCNTB5cThsZFBj?=
 =?utf-8?B?KzlsdDdselB6aDVyVVBZV0lXRmZqMXF5U2ZpSllHUVd1dUZTN3BKYkJqL3hu?=
 =?utf-8?B?Z3hBT0dBc2JNd1UxeDJYdGZITzVibXVCbEVtQndqa2ZnYk9Rd3FTWFphODAw?=
 =?utf-8?B?Ky83UzhGQlE0cEMyekdQVVcxSFdaMjczVjRwSVNMMlErYW53MjRQcDdsbFl0?=
 =?utf-8?B?eTFVekxkU2Z5d3Z4T1BuVUJrcnJpdWp2Zk5LUEhoNGNJZ3l6MlhBRnBUa0E5?=
 =?utf-8?B?dVZBNFZQUGo4bGxPNjg3SUhZSGFvV01UZDhVOW9oUWRLc3R4MTRyQWNEVEMy?=
 =?utf-8?B?eWlwOE5pSzBzYWdMM2l5dkpJaTR0T29TYzQ4aTBseWQvK3VxYXZCd1VvY2ZX?=
 =?utf-8?B?TkhiRWtad05wYnQ2T3JNN0dpYnV3TnNXbUUvc2I4NGdLRXVoUElzZzBaYWZL?=
 =?utf-8?B?bERZZWxqTWJjUk5BdWVUNVQyd24va3JRR0tYRFNFMERrWTl2UW9qVjZya0FE?=
 =?utf-8?B?OFFtUVZCNDg1Z1MwMW9vU0JXemNpVmNsMUZidms4VDlROTB2bVNPRVdRWmpr?=
 =?utf-8?B?WmxQYmhLdXk0RExBWVNIVTNlcmxFT0YxUWl1SnhEb2VsNkVSbExFNUR1TGg0?=
 =?utf-8?B?b1pkKzJDZVdjMktQSUNjT0xiaVhXb21XVVo3Y0VneEJocXYvZms2bzhWRkJ5?=
 =?utf-8?B?OVA4cGNhZUQ0a2dOTDQ1ZllSNXQrdDU3RVdORFBFelo1TGgweG9CZ2xkakln?=
 =?utf-8?B?empPUU1lNXE2VHZ0dElNczFyYmFZelJEOW5KTkxYOEFpckFHT3lBbGdnYmlE?=
 =?utf-8?B?dnMwNmlwWmk3UVBrOTFMR0c4d2pHam9qSFo3cVFiVkdjRWtoRnZjREpibVg0?=
 =?utf-8?B?d2NEc3lyVlkvWlZlZHV4aWVsZXZBWWdpS0lWd3VIbHNhOVZpQUFKREo3RURV?=
 =?utf-8?B?ZXJSM3ZBNnJQMzFtWWkzdnN0Ty8rTDYyZE9MUmM0WHU4bVRpOXE2RVk3Rkpk?=
 =?utf-8?B?RGdUSHhGM0FGWVEwcm00ZnMySk5zS2FtYUJqT2Z0c3N3QkE4aC9aVWtRQUpm?=
 =?utf-8?B?ZUVyYUt1MHkzbWU0bXZMYzhObjhnQmphRS83cEQvK0tnMmFBdEE3UXlmb0pT?=
 =?utf-8?B?VW50amQ1Ym54S2dZVmJwWjJPeEY3c3gyOFZBS0IyRjM3cGkyYTZVK1BUanFL?=
 =?utf-8?B?VTA3VDZLeW1hakNWbDI2d0Evd0VvSXVvQ1FnaXRhQTduTHhlMlY0TkJzTEhu?=
 =?utf-8?Q?Qda1Y3RUyjX8wFEFY4DLWmrdQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E999D6C9ECE9F4DBB6F06DD3FA8E5E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WHJ1T1hodVA1VDJ2Q3Y0NWEzbERQSjQ4TnUxeXQwUS9jdG5zU2p4MnZsUVZa?=
 =?utf-8?B?Y1NQUFdCa1owL2NVNXVhMG1UK2hRdlh1cFo0MDJjVEJYTWx2MlozS1BDM3hw?=
 =?utf-8?B?MVcrQmhySWUvZm0rSVVEUkM2aE5tUmRsTDFFVzkrVlZEOXAvMG9XWHp4Z0hp?=
 =?utf-8?B?NW1SZDIvb1B1ZDB2T2F5UGZWUmhKakF5dVphRU1kZFdRazBQZzVTaHFRRFVW?=
 =?utf-8?B?MlNDMXozNGdWY2g1RHVPQ3B1YWRrM2hObURaeTgxSExDcGpNcFcwcGpBb2tz?=
 =?utf-8?B?MmpTcHBhZThpSEo1YS9WYSsrNWhlQlBDR29MRmZBWGFvODNRREhQSTVoSkI2?=
 =?utf-8?B?NjIvVTZYZ011NUlEV01NUy9TZjJPRldvVEMxRnFZRE5ZckEwNGJXWjVYUStT?=
 =?utf-8?B?cnYvcERhZXp6azI2MWRVVlRNV1hVcjBFbERMVyt4MTAvS3BLM0RveWcyNG11?=
 =?utf-8?B?K3N5UTNFdTFpOGVXVmk0WmNKVHQvWTN0VnZ5VGhldkJzS1FabHY5TUFrVlFl?=
 =?utf-8?B?alVHZm1wY1N5aDYrTXBKV3VBcmhtYmZ4QjY3eU8wbVZWanAzTEFEZERsc2p3?=
 =?utf-8?B?NVdnVVBpNDE0ejVWVGh1aitNbFhLMEpVY1Byb2FZdGkzeXY3cEdQcThZQzY5?=
 =?utf-8?B?Rm5Db1NYdi9RQ3NGM3paR2hlOEwxeWJmZ3lFUHFwSHMxV1VNYWYxYTQxUk1x?=
 =?utf-8?B?b1ZEZm1RYU9YTllXdVduVGxMbmtBK3ZBWDdJYy94NFdGOGZjaHdsM25DR0dv?=
 =?utf-8?B?RXphSE5XMFdRVUJjTDhoK2Vwbnp2dnh2Y3N4c0I1WnJ5cnBhQTdOTmNrbFhP?=
 =?utf-8?B?VW9hNEw2aWxZVHd6LzZNekt0NDVYMDRaWVJjRkU5N1NWQzEyTTBiWk5LZGQy?=
 =?utf-8?B?Z2lkNlRVSUw0LzdQMHQ5NlgzUFBPMW5EZkdyNEFuMUNYb1huSHVSdjRQUVVu?=
 =?utf-8?B?bnU2VjdxN3ZPalVMVjJmY3B1VHZRbkdxMW5UbDVobFhXTnZ6T3FVZ3VTejdT?=
 =?utf-8?B?SDU5WEFlWUtVeU50aXAzb21kSVBMSHhhM1pGQmcxTDZrNDJHZXlueFEyVlhK?=
 =?utf-8?B?ckNkQ2RjSmM5Vmw2cGQwelYyQ2ZaM2l0TEtLT0ovdU90Y0ZMR0c1UlRGVUQ3?=
 =?utf-8?B?by8xSUU0U3oxK3AxaTBrbm5Pd1FLNHp6L2VnUVdqckszV284SUM2cW1ra2lI?=
 =?utf-8?B?Z1Y4aERFOU13MUVWRGFGUVVJS2hTTWdQR0srWUYzVG5pcFJSemVPbHNxMXlw?=
 =?utf-8?B?Ty9MSkNIVFV4QVg3VGxXdVQ2NlJpNW1lREVrbHpwTVZ4VnhaQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd19ddb-3a02-4aca-f181-08dbe71d4afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 03:28:40.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKGPu/tjPZUFEYFndZNkOIYM3R2rnc4x+HgF/zAMx9KGe9Kc60mnqAOUDDK6T+OjBHV/muFlPWplq8qpuOkbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
X-Proofpoint-GUID: EBMpl2N0ch6ObLY6-6Q1u4G4hk7kodF0
X-Proofpoint-ORIG-GUID: EBMpl2N0ch6ObLY6-6Q1u4G4hk7kodF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxlogscore=544 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMTcsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGksDQo+IA0KPiBP
biBUaHUsIE5vdiAxNiwgMjAyMywgRGFuIFNjYWxseSB3cm90ZToNCj4gPiBDQyBUaGluaCAtIHNv
cnJ5IHRvIGJvdGhlciB5b3UsIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgd2UgZml4IHRoaXMgaW4g
dGhlIHJpZ2h0IHBsYWNlLg0KPiA+IA0KPiA+IE9uIDA4LzExLzIwMjMgMTE6NDgsIEt1ZW4tSGFu
IFRzYWkgd3JvdGU6DQo+ID4gPiBPbiAwMi8xMS8yMDIzIDA3OjExLCBQaXl1c2ggTWVodGEgd3Jv
dGU6DQo+ID4gPiA+IFRoZXJlIGNvdWxkIGJlIGNoYW5jZXMgd2hlcmUgdGhlIHVzYl9lcF9xdWV1
ZSgpIGNvdWxkIGZhaWwgYW5kIHRyaWdnZXINCj4gPiA+ID4gY29tcGxldGUoKSBoYW5kbGVyIHdp
dGggZXJyb3Igc3RhdHVzLiBJbiB0aGlzIGNhc2UsIGlmIHVzYl9lcF9xdWV1ZSgpDQo+ID4gPiA+
IGlzIGNhbGxlZCB3aXRoIGxvY2sgaGVsZCBhbmQgdGhlIHRyaWdnZXJlZCBjb21wbGV0ZSgpIGhh
bmRsZXIgaXMgd2FpdGluZw0KPiA+ID4gPiBmb3IgdGhlIHNhbWUgbG9jayB0byBiZSBjbGVhcmVk
IGNvdWxkIHJlc3VsdCBpbiBhIGRlYWRsb2NrIHNpdHVhdGlvbiBhbmQNCj4gPiA+ID4gY291bGQg
cmVzdWx0IGluIHN5c3RlbSBoYW5nLiBUbyBhdmlvZCB0aGlzIHNjZW5lcmlvLCBjYWxsIHVzYl9l
cF9xdWV1ZSgpDQo+ID4gPiA+IHdpdGggbG9jayByZW1vdmVkLiBUaGlzIHBhdGNoIGRvZXMgdGhl
IHNhbWUuDQo+ID4gPiBJIHdvdWxkIGxpa2UgdG8gcHJvdmlkZSBtb3JlIGJhY2tncm91bmQgaW5m
b3JtYXRpb24gb24gdGhpcyBwcm9ibGVtLg0KPiA+ID4gDQo+ID4gPiBXZSBtZXQgYSBkZWFkbG9j
ayBpc3N1ZSBvbiBBbmRyb2lkIGRldmljZXMgYW5kIHRoZSBmb2xsb3dpbmdzIGFyZSBzdGFjayB0
cmFjZXMuDQo+ID4gPiANCj4gPiA+IFszNTg0NS45Nzg0MzVdW1QxODAyMV0gQ29yZSAtIERlYnVn
Z2luZyBJbmZvcm1hdGlvbiBmb3IgSGFyZGxvY2t1cCBjb3JlKDgpIC0gbG9ja2VkIENQVXMgbWFz
ayAoMHgxMDApDQo+ID4gPiBbMzU4NDUuOTc4NDQyXVtUMTgwMjFdIENhbGwgdHJhY2U6DQo+ID4g
PiBbKl1bVDE4MDIxXSAgcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDg0LzB4Mzg4DQo+ID4g
PiBbMzU4NDUuOTc4NDUxXVtUMTgwMjFdICB1dmNfdmlkZW9fY29tcGxldGUrMHgxODAvMHgyNGMN
Cj4gPiA+IFszNTg0NS45Nzg0NThdW1QxODAyMV0gIHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVz
dCsweDM4LzB4MTRjDQo+ID4gPiBbMzU4NDUuOTc4NDY0XVtUMTgwMjFdICBkd2MzX2dhZGdldF9n
aXZlYmFjaysweGU0LzB4MjE4DQo+ID4gPiBbMzU4NDUuOTc4NDY5XVtUMTgwMjFdICBkd2MzX2dh
ZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cysweGM4LzB4MTA4DQo+ID4gPiBbMzU4
NDUuOTc4NDc0XVtUMTgwMjFdICBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIrMHgzNGMvMHgz
NjgNCj4gPiA+IFszNTg0NS45Nzg0NzldW1QxODAyMV0gIF9fZHdjM19nYWRnZXRfc3RhcnRfaXNv
YysweDEzYy8weDNiOA0KPiA+ID4gWzM1ODQ1Ljk3ODQ4M11bVDE4MDIxXSAgZHdjM19nYWRnZXRf
ZXBfcXVldWUrMHgxNTAvMHgyZjANCj4gPiA+IFszNTg0NS45Nzg0ODhdW1QxODAyMV0gIHVzYl9l
cF9xdWV1ZSsweDU4LzB4MTZjDQo+ID4gPiBbMzU4NDUuOTc4NDkzXVtUMTgwMjFdICB1dmNnX3Zp
ZGVvX3B1bXArMHgyMmMvMHg1MTgNCj4gPiANCj4gPiANCj4gPiBJIG5vdGUgaW4gdGhlIGtlcm5l
bGRvYyBjb21tZW50IGZvciB1c2JfZXBfcXVldWUoKSB0aGF0IGNhbGxpbmcgLmNvbXBsZXRlKCkN
Cj4gPiBmcm9tIHdpdGhpbiBpdHNlbGYgaXMgc3BlY2lmaWNhbGx5IGRpc2FsbG93ZWQgWzFdOg0K
PiA+IA0KPiA+IMKgwqDCoCBOb3RlIHRoYXQgQHJlcSdzIC0+Y29tcGxldGUoKSBjYWxsYmFjayBt
dXN0IG5ldmVyIGJlIGNhbGxlZCBmcm9tDQo+ID4gDQo+ID4gwqDCoMKgIHdpdGhpbiB1c2JfZXBf
cXVldWUoKSBhcyB0aGF0IGNhbiBjcmVhdGUgZGVhZGxvY2sgc2l0dWF0aW9ucy4NCj4gPiANCj4g
PiANCj4gPiBBbmQgaXQgbG9va3MgbGlrZSB0aGF0J3Mgd2hhdCdzIGhhcHBlbmluZyBoZXJlIC0g
aXMgdGhpcyBzb21ldGhpbmcgdGhhdA0KPiA+IG5lZWRzIGFkZHJlc3NpbmcgaW4gdGhlIGR3YzMg
ZHJpdmVyPw0KPiA+IA0KPiANCj4gTG9va3MgbGlrZSBpdC4gVGhlIGlzc3VlIGlzIGluIGR3YzMu
IEl0IHNob3VsZCBvbmx5IGFmZmVjdCBpc29jIHJlcXVlc3QNCj4gcXVldWluZy4NCj4gDQo+IENh
biB3ZSB0cnkgd2l0aCB0aGlzIHBhdGNoOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDg1OGZl
NGMyOTliNy4uMzdlMDhlZWQ0OWQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE2ODQsMTIg
KzE2ODQsMTUgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoc3RydWN0
IGR3YzNfZXAgKmRlcCkNCj4gIAkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3Qo
cmVxLCBEV0MzX1JFUVVFU1RfU1RBVFVTX0RFUVVFVUVEKTsNCj4gIA0KPiAgCQkvKiBJZiBlcCBp
c24ndCBzdGFydGVkLCB0aGVuIHRoZXJlJ3Mgbm8gZW5kIHRyYW5zZmVyIHBlbmRpbmcgKi8NCj4g
LQkJaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPiAr
CQlpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9QRU5ESU5HX1JFUVVFU1QpICYmDQo+ICsJCSAg
ICAhKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4gIAkJCWR3
YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKGRlcCk7DQo+ICANCj4gIAkJ
cmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gKwlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1BFTkRJ
TkdfUkVRVUVTVDsNCj4gKw0KPiAgCWlmIChkZXAtPnN0cmVhbV9jYXBhYmxlICYmIHJlcS0+cmVx
dWVzdC5pc19sYXN0ICYmDQo+ICAJICAgICFEV0MzX01TVF9DQVBBQkxFKCZkZXAtPmR3Yy0+aHdw
YXJhbXMpKQ0KPiAgCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfV0FJVF9UUkFOU0ZFUl9DT01QTEVU
RTsNCj4gDQo+IC0tLQ0KPiANCg0KQWN0dWFsbHksIHBsZWFzZSBpZ25vcmUgdGhlIGFib3ZlLCB0
aGF0J3Mgbm90IGNvcnJlY3QuIEknbGwgc2VuZCBvdXQgYQ0KcHJvcGVyIHBhdGNoIGxhdGVyLg0K
DQpUaGFua3MsDQpUaGluaA==
