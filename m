Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713C37E2E61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjKFUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:44:10 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB410A;
        Mon,  6 Nov 2023 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=616; q=dns/txt; s=iport;
  t=1699303447; x=1700513047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qqSBLWFlX2m/UGEZj+dJ1iJauydyYugVBZEIu9qV7tw=;
  b=k3aYNXRAQFN3tRaNwtJ08uDRtZctrsdi05fxcZ/SckvwJFacHlSMwS29
   +Rh/dPMKLOv0TWer33FRDzBV72Xrxr9NGirV0x62xk5Caba3M2DvM9h5I
   /C0fsadAAubEpfKTjf57SBx6fuU/dUVmbThZDJlrUqqbFfvNyWI2FNeSQ
   g=;
X-CSE-ConnectionGUID: HLs/F899RKCU2bGAjNzBbA==
X-CSE-MsgGUID: 4CmgwUOpRlCBQpHhsM+YAQ==
X-IPAS-Result: =?us-ascii?q?A0AnAAC/TkllmJBdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoGABgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BV4I3M?=
 =?us-ascii?q?T6CYQKBYoNZOYIviS4HMoIig1SNEwl3R3AbAwcDgQAQKwcEMBsHBgkULSMGU?=
 =?us-ascii?q?QQtJAkTEj4EgWOBUQqBAj8PDhGCPyICBzY2GUiCWAkVDDVKdhAqBBQXgREEa?=
 =?us-ascii?q?gUYFR43ERIXDQMIdh0CESM8AwUDBDMKEg0LIQUUQwNCBkkLAwIaBQMDBIE2B?=
 =?us-ascii?q?Q0eAhAaBg0nAwMTTQIQFAM7AwMGAwsxAzBVRAxQA2wfNgk8CwQMHwIbHg0nK?=
 =?us-ascii?q?AI1QwMRBRICGAMtA0QdQAMLbT01FBsFBDspWQWhI4JAgTiWHkmuMwqEDKE/F?=
 =?us-ascii?q?4NuE4xzmQyYPiCCL6VZAgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gGR+DQI95d?=
 =?us-ascii?q?jsCBwsBAQMJi0oBAQ?=
IronPort-PHdr: A9a23:vk664hzNZreMlXDXCzMRngc9DxPP853uNQITr50/hK0LKOKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAl8PPj0HofRp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:D2/h+aknmZVfHUGGMwPWRKro5gy8JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXUW7XOKmOMGWgfIx2YNy1oEgHupTdxt5gGwI6qCsxH1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5a31GONgWYuaTtNs/zb83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvAVyk9uLDnhz8UFDRmf9BJUMQL6cS07MiaY1O3
 aRwxDEldBuPgae9x6i2D7kqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuYMwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yKmI2YF8g7JzUYxyzT4yQNu7Z/1Ct7+UOWSZcVOuwWpj
 1uTqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaM
 EcP+wIwoqUosk+mVN/wW1u/unHsg/IHc8BbH+t/4waXx++EpQ2YHWMDCDVGbbTKqfPaWxQK8
 kTOsYO4VAZMm4DPQ1209JGGhzmbbH19wXA5WQcISg4M4t/GqY41jw7SQtsLLEJTpoCrcd0X6
 23axBXSl4n/nuZQiPrmpQGvbyaE48mWHlRst207S0r8tlshDLNJcbBE/rQy0BqtBJySQl/Et
 38elo3OqusPFpqK0ieKRY3h/Y1FBd7balUwYnY2QvHNEghBHVb/J+i8BxkldC9U3j4sI2OBX
 aMqkVo5CGVvFHWrd7RrRIm6Ft4ny6Ptffy8CKGFNIsTPsQpJFLflM2LWaJ29z61+KTLuf9nU
 ap3je7wZZrnIf09lWHvF7t1PUEDnHhnmws/uqwXPzz+gebBOxZ5uJ8OMUCFaagi/biYrQDOm
 +uzxOPUoyizpNbWO3GNmaZKdAhiBSFiWfje9ZcNHsbdeVUOJY3UI6KLqV/XU9Y7z/09eyah1
 izVZ3K0P3Kk3iKfcFXbNS85AF4tNL4mxU8G0eUXFQ/A81AoYJ2k6+EUcJ5fQFXt3LYLISJcJ
 xXdR/i9Pw==
IronPort-HdrOrdr: A9a23:KP8l3a3xpzoDk5hKiDjIFAqjBfdxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7LU819fZOkPAs1MSZLXnbUQyTXc9fBOrZsnLd8kjFh4xgPM
 hbAtVD4bHLfD9HZIPBkXeF+rUbsZi6GcKT9JvjJh5WJGkABdAEnmNE40SgYzJLrWJ9dOIE/e
 +nl7B6Tk2bCA8qh6qAdx84dtmGjefm0LjhZhkLDQMm7g6hsROEgYSRLzGomj0lf3dq27kNzU
 jp+jaV2kykiZ6G4y6Z81WWw4VdmdPnxNcGLteLkNIpJjLljRvtTJh9WpWZ1QpF492H2RIPqp
 3hsh0gN8N85zf6ZWeuuybg3AHmzXIH92Li81mFmnHuyPaJBg7SSvAxwL6xQCGprHbIj+sMlp
 6jGFjp7qa/OCmw2BgVIeK4Dy2C2HDE+kbK2tRj/EC3GbFuGoO567ZvvH+81Pw7bX/HAEdNKp
 g1MOjMoPlRal+UdHbfoy1mx8GtRG06GlOcTlEFodH96UkdoJlV9TpR+CUkpAZKyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZQ2PLtBKB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8Wo/YVjnB8GC1IBCthrNXGK+VzLwzdw23ek1hpTsAL7wdSGTQlEnlMWt5/0ZH83AQv
 62fIlbBvfyRFGeULqhHzeOLaW6BUNuJ/H94OxLLm5mivi7XrHXig==
X-Talos-CUID: =?us-ascii?q?9a23=3AKJOOomnoj4wqC8iPApXztIcdlATXOV351zD+cx7?=
 =?us-ascii?q?pM0VCdeefZnaS3rFOmeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aa2E7IA2yHX8JNVwSsrB7DRWD7jUjv4+rB18wto0?=
 =?us-ascii?q?8v+KuDDRQOyy4zwWee9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:44:06 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6Ki5hn024328
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:44:05 GMT
X-CSE-ConnectionGUID: h3DhiKzESImDevB9CpG7pg==
X-CSE-MsgGUID: gcG2Gpi1QxyBFhXS4+VKvA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7216878"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq1QzhzI++5D+evCvF8HgZ3thfUNJWhwr65+VFT0xMYZLV1xMTBWPkdW6H6uyqn5jUZRDjS5/ERUuPr+ZUOv2Op2a83nuwu3++T3PK7e1Yd19SCycqkJk92AvYQ+DSIUuGT7kd/PkPIQpEYqk7ISL9jB+GIl4k0hfbkkBRGq24wksam9sLtDB9bw7EhxozeNP2kJmvCbG7Ke1pOhyLJbUwgb9NorA0iqo6Le7bMzewGYp6pPxqWtuQ70JzRg0uiIT1/+7lHXvwUv1RwRIfgErBlgKGHLh5lyv6layO+tnB3bJMfh999qPCsSJS3jsGe7qjJ5yNXDC2iBclywgff0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqSBLWFlX2m/UGEZj+dJ1iJauydyYugVBZEIu9qV7tw=;
 b=TscE3aKxoXtsoTK7/c1vWCZeeUkOy973X6mWg3cg/vl+ezrGEQpt2ZsJfRd2qf2hC/t0mj7fVGxIwbaOK9XpZg/0dineaRdxWnTRD9MZZRYgrgP9VvruWTzt15FrHWJXMTDcFI7R0pYu6Hf6s+RmxJ9entvg87FulSyn1efTLL+uoffwUswgZzsF6akD/cfaNDuY6fP32Z6XF9JSHY/7vissYpBkPhtuUaKaZYcZEpifB7PIDANfYm2OLUH7TcRq4PVPN9V8ZVW02GHJ3lPC5+VJoZeKPuCniTygUjis+Aw5DhUi2zXpnRB8HukS23M/MFXUnwI+eQDN5Cw/OKWppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqSBLWFlX2m/UGEZj+dJ1iJauydyYugVBZEIu9qV7tw=;
 b=Aqe0Qle5+WmvEaoBZcTvOnGs59h5Y69xsmVojTSiG2GerdTqJhMv5Bis3gCLtCWW/Tv9Q0BEDjZs8VauMuSnguGmvYObv3aLnLN/au9hzIrKU10xUCNrrhRACMKSNpxlCG05J2vOGwSdHhOLHkuAIRB4MDYzZ15vQPWble8sAR0=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:44:03 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:44:02 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Topic: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Index: AQHaCP/2MFkSdLeZq0m6/Pp6+iIsGLBmsvEAgAcb0ZA=
Date:   Mon, 6 Nov 2023 20:44:02 +0000
Message-ID: <SJ0PR11MB5896E9241A26DACE35684E12C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-14-kartilak@cisco.com>
 <2e7c1749-428b-4c88-8e0e-df6ed4d8def5@suse.de>
In-Reply-To: <2e7c1749-428b-4c88-8e0e-df6ed4d8def5@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA1PR11MB6513:EE_
x-ms-office365-filtering-correlation-id: 1a0a77dc-e5a5-4faa-56ed-08dbdf091c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyrgrKA9EPLGhorMxqTLkOWaxrDCEyW4o9w75D2Fwz/LS1vCsy0FRDevw5j6iT6GTixSskMiJQ32qy4BqMb6X6xBpCwtSuZxbOeHE8n/sLP7Af+GIDwNnuO+rfd1cSAXSI7nY5Es5C0lVdIY4t9RAotbvWbcjuCmXMkmEW6gNndti4C+aFmEPNkFORauPlPBjPRRSpkTewo7WEl0zzCBAfFZbk7ir1lg3bKlEC4rmSukSwwtZ693EXWe7xpxR/kEPOUpTrcDE00mZZlao+jVTZxjA6V8PpWfdrkiX3JovRdmIfTK8qwJFtd81ZV7bDDdbwYt8KXfvvbYnmz3j7hcfrcMt0I01XetpqFoQI48+KxljgwZhUSacMH9Wfy2tCFUejHA6O2u79jLm54dpqpA7lSzDR/xgRC5xNyy7EP13p7pvnuVBth0akqtXzwhW86/DUrgNVfcuozGzMxMqS9HfXsOdXt1iIXDphF3olUiEkuuiBT1NN1MZAhaPGD1/ScwjLCmBFJVuO+rSQ+t1Jqwof7Hgt6tjNdr2wXR8pL9O/v9wkgBRnTNCqHpi9Ar3t2DNiTfWzryxaLHcKQygK3rzboX9Gu+sAquXfr2q+NWHiNgEdnmtdqAnOGG7US0NJxy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55016003)(83380400001)(33656002)(4326008)(52536014)(8936002)(38070700009)(41300700001)(86362001)(8676002)(2906002)(4744005)(53546011)(478600001)(110136005)(7696005)(71200400001)(6506007)(38100700002)(6636002)(316002)(122000001)(5660300002)(66446008)(54906003)(64756008)(66556008)(66476007)(66946007)(9686003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDVHdk5sMXVBN3lteEE1ZGNUd2RnWkpkeGsrM0ZWWmVmdG1CTG82RWw4eWhK?=
 =?utf-8?B?U1FaUTI4S1N0YTcxckdXNnBqZG5kaDEyMWltYkVybExSYXFqUmdNQ2VycnhW?=
 =?utf-8?B?TWZnT2psUks3V1pDaktxa3JvOXhza3pPTzZaUEZoYmZQbHEwWE5xOVViMUZI?=
 =?utf-8?B?VCt3QWZraldMSHUzSWtDMEt6eWV2bS9hSnZFaE5FcWtWdS9XOFpBcWZmQjNH?=
 =?utf-8?B?aWZVQjluUG9FL2xHUDFxUnZyN1JUTTNBNWJRQTl0QmdWcGlwYjVMYVRBYlVl?=
 =?utf-8?B?N2c3eE9VTHBhSGV6VDFjT0VUWjR0VndITlNmRlFuZmV1ZDNYc2xKTnhxYTdL?=
 =?utf-8?B?SHhnT040NnoxcktUbEJweXZMTHY4bEdFVnZ1enBNUTV6ZVBUeGJFOVEzNU5m?=
 =?utf-8?B?bDZWc2hreVRjWFRTQm9nYXhZTHUrajN3dEZnWkRQRGsyR01LTlhraUFMemVV?=
 =?utf-8?B?WG40NUlEczV0NTNZa3B3eFIvcHZzdFJzVUl3ODdyeFRNU21aVlRzZDA2TUsv?=
 =?utf-8?B?eHlkaWZXb2l4dkNZV0RMcGp4dkR3UmNRVWlKM3BYVkQwbGtUZVZOQlBVU1c3?=
 =?utf-8?B?NFk3T1Y4M0hyMW9PMjFEeEpyYkErdGFBYUJoUUVUSGt2WUd1dEVPQjR6QW1R?=
 =?utf-8?B?dmdxdy9pZVFrSHRWTk1FMHc4d3AzVGtUeDBXTzJyWjdaZjZaNE5vckxpYUpB?=
 =?utf-8?B?enl0cU1Qelh5cjlwRnczem1GTHI4MG9saWFpcDNTd3dPbU80cy9tb0MrWTU3?=
 =?utf-8?B?MnJUZzZDejBmdWlBNlpXNERhTFE4YUkyNTdPa2ZrZSt2eFcwdkJ0dHdyVDZa?=
 =?utf-8?B?MC9JVjJSYTQ3UWlKbUxqV0lDRExNajcyNkE3b3N1dXBEUGtwRkFFZ0ViZ21s?=
 =?utf-8?B?ZENPSllSazk0RE5SbDJRenBXSjBHLzNIT0lwcksxYWYxWENjczE2VE5ibU5r?=
 =?utf-8?B?VlQ3dzI4WjBqYXBRbEQvckFvZWhtSXo2NkJySjJZYTBIYUZvZEM1czcxanJk?=
 =?utf-8?B?SldNaDNjWlYyYXFCSUNzNTdPUFQrUUZRSk5mNTZ2d2RFVjFZcTdhcW81U1p5?=
 =?utf-8?B?R3p0TXRjSXFpNlBoNk1QVHZBdWRZbkJNTThYYmRtM0JQQVp3NklHaXpnRWdX?=
 =?utf-8?B?R2pMaDNtYStseVVIb3o5WDdYK3R5djc3U2R3VytqUDNUaW1FdXVDYy9ReGVT?=
 =?utf-8?B?czRqV3B2Y3BzQXBaaEpGUnppcmh6dktNL2lHcTNSc3kvaHNRMUMvV1hvZHIv?=
 =?utf-8?B?ZDNyR2VVQ0tKRDk5TkVmNElHVmFKVXBwQVdRMnQxakxTaEU2RitHSXpPQWhL?=
 =?utf-8?B?TVBJbm9UaTU1b3ZOalVLenRRMHJ0b1RqZWxkWk41SDNOZmZvajh0aHVDaXB1?=
 =?utf-8?B?V1hJZ3ZJSE9TL053R3VjQjZtZ2xrcEkzNVRaSDJyZTBxSFFta2hUa21vN2Y0?=
 =?utf-8?B?T3FLdGlmd3NTT1cxOThGV0ZQSjRBR3hmalc4R3NBYk1QZHZmTmdzb3dyRUVP?=
 =?utf-8?B?TnQwVTBNODBtZjludDBFTE0ydk10dmRobUZ1MzVzdlZvSmtxNTRscGJFbWVi?=
 =?utf-8?B?QjVsK09WQmR5cWVGMEdXaUdwYjgzc0p1YS9xNU10M21DZTFoS3lkeUZ6VHR4?=
 =?utf-8?B?OWhJMUlEWUZicnhaTG02UjhSYTRkek84T2MyclRqQmxkakVVNG4wbkR3VjlD?=
 =?utf-8?B?b2ZGd1FndmhVU01OLzJZUkhqWHQ0dVpzd2tGTFdNTjgwQXgwc2Jjd05qOFJo?=
 =?utf-8?B?dTRVWENXVnk5dVl3b0pkd29EU05Hc0d1QkZzQ2tFSTVSWE5mbUFkZFBycjd2?=
 =?utf-8?B?aDh3M25Lb2V4eDVtWmJHRFpGcnluMS8wZW1PUVV6K0Y1OEFiaHVYYjFxUWM0?=
 =?utf-8?B?Nm03UUVCL0ordGFsQTFURU53OVVzWlZlR0ZaaGdRbkJOdWZpdHVQcEpvRUJw?=
 =?utf-8?B?d1VBaUR2R1BkZ3hYYW1qVklPZk40T1dnNVowRmRXMWhuU0xUaWdBRStORWRZ?=
 =?utf-8?B?elJieGxFbThQR0hJcTFPem9xTEYzc01hQnl2YXJtanZMME1HbHY0K1BrdlM0?=
 =?utf-8?B?Q1Ntc1BHTEJzaUJ5T1lxOSsvOHpvQ21oUThXWUlra2dKeHdKcUovTkk5dlA4?=
 =?utf-8?B?TFlHVi9QOWliRC9oT2Nab1ZxYWRlOGl5MTBndnhTOUkvNFpnRVRXQWMrZ2pE?=
 =?utf-8?Q?z0O5NJezd4863VQYuVrdLWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0a77dc-e5a5-4faa-56ed-08dbdf091c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:44:02.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kGD1EDHCDUgdMHDjbC6w9s9NGT5ME9F4u2tsj4eApob6En1K4zLKL+qkAIpgF8+UFjXFQnp4CBkJo/J7AuM3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6513
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6NTkgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4gUGxlYXNlIG1vdmUgdGhpcyBjaGFuZ2UgdG8gdGhlIGxh
c3QgcGF0Y2guDQo+IEFuZCBJIHdvdWxkIHdhZ2VyIHRoYXQgdGhpcyBjaGFuZ2UgaXMgbW9yZSBp
bnRydXNpdmUgdGhhbiBhIHNpbXBsZSBwYXRjaCwgc28gYW4gdXBkYXRlIHRvIDEuNyBvciBldmVu
IDIuMCBpcyB3YXJyYW50ZWQuDQo+DQoNClRoZSB2ZXJzaW9uIGNoYW5nZSBpcyBpbiB0aGUgbGFz
dCBwYXRjaCBvZiB0aGUgcGF0Y2hzZXQuDQpEbyB5b3UgbWVhbiB0aGF0IEkgbmVlZCB0byBtYWtl
IGEgc2VwYXJhdGUgcGF0Y2ggdG8gaW5jcmVtZW50IHRoZSB2ZXJzaW9uIG51bWJlcj8NCkluIHYz
LCBJJ2xsIHVwZGF0ZSBpdCB0byAxLjcuMC4wLg0KDQpSZWdhcmRzLA0KS2FyYW4NCg==
