Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885378263E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjHUJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHUJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:28:15 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2624CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692610082;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g/b2oxr7Ymwdi38HwV6yePl9p9yPKTPyi9z7Y/8n9So=;
  b=dkVeAgY7oIS494NtvW0Z2LMtpk5mFVfc3yUh1aaF+B0v+9iko2HJ7/bi
   11EVyxib2BlCjdnpeHgCx9ocV5SuF3SyGRlgkIHoZK4cBi7nfpGkfR1/m
   RRS1Sy2Gf5hTvfwlae2TTybCXzn17k3RyiGamZnCwhXc6RF+DGorzSiIH
   M=;
X-IronPort-RemoteIP: 104.47.55.170
X-IronPort-MID: 118774590
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ieYYeKyH1dZ3JweGHN96t+daxirEfRIJ4+MujC+fZmUNrF6WrkVVm
 zEWXG6GOvmPNGr0f94jYITi80wHsJKHnNZmHgpu+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EoHUMja4mtC5QRuP6gT5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KX1s0
 8UINx4VV02ovOfxyY2QdepBwct2eaEHPKtH0p1h5RfwKK98BLrlE+DN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjWVlVMpuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiAdJNS+Hlp6YCbFu7gVFQMToXd0KH+d6DgHyvXftCN
 0MKw397xUQ13AnxJjXnZDW6uHmFuxQbVvJTHvc85QXLzbDbiy6JVjYsTTNbbtEi8sgsSlQC0
 l6PgsOsBjF1trCRYWyS+63Srj6oPyURa2gYakcsRxMt6t3irYdjyB7CJv57HbK4lM/dGDf+2
 TmGoSEywbIJgqYj3ayx4BbChD2hvLDASwJz7QLSNkq95AR/do+jZqSy5FTb5OoGJ4GcJnGas
 XECmcO24+cJApWA0ieKRY0lMLi35vrDEzTEhVdpN5Ak+3Km/HvLVYZR43d0I11oKcEaUST0e
 0KVsgRUjLdcJnalbq9fZ4O3FtQkyrXmGd35V/fSKN1UbfBZaACD7AlqZEiNw3rqlkk8160yU
 ap3au6pBHceTK5hnDy/Qr5H1adxn39mg2TOWZr80hKrl6KEY2KYQqsEN13Iaf0l6KSDo0Pe9
 NM329a29iizmdbWOkH/mbP/53hTRZTnLfgac/BqS9M=
IronPort-HdrOrdr: A9a23:RGHkHqkn3RJfk3hJfCcj95w/I2HpDfNKiWdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7V5Voj0msjKKdkrNhWotKOzOWxVdATbsSl7cKpgeNJ8SQzJ8/6U
 4NSdkaNDS0NykAsS+Y2njHLz9D+rm6GcmT7I+xrkuFDzsaE52Ihz0JdTpzeXcGIDWua6BJcq
 Z0qvA3xQZJLh8sH7iG7zQ+LqH+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd8gYCXyhJybIC93
 GAtwDi/K2sv9yy1xeZjgbontlrseqk7uEGKN2Hi8ATJDmpogG0ZL55U7nHkCEprPqp4FMKls
 CJhxs7Jcx8517YY2nwixrw3AvL1ioo9hbZuBWlqEqmhfa8aCMxCsJHi44cWhzF63A4tNU59K
 5QxWqWu7deEBuFxU3GlpP1fiAvsnDxjWspkOYVgXAaeYwCaIVJpYha2E9OCp8PEA/z9YhiOu
 hzC8P34upQbDqhHjjkl1gq5ObpcmU4Hx+ATERHksuJ0wJOlHQ89EcczNx3pAZ1yLsND71/o8
 jUOKVhk79DCuUMa7hmOesHScyrTkTQXBPlKgupUBXaPZBCH0iIh4/84b0z6u3vUocP1oEOlJ
 PIV04dnXIuenjpFdaF0PRwg17wqV2GLHfQI/xlltpEUuWWfsuvDcTDciFgryKYmYRePiWBMM
 zDfK6/AJfYXB7T8MhyrkrDsqJpWAojuf0uy6cGsm2107L2w63Rx5vmmaXoVczQOAdhfF/DKV
 0+exW2DPl8zymQKw3FaV7qKj/QRnA=
X-Talos-CUID: =?us-ascii?q?9a23=3AguylUGjG3CCNDpjVPYBFabf1wTJubl/79WfPDVe?=
 =?us-ascii?q?BVE1STfqcdnSv+44jnJ87?=
X-Talos-MUID: 9a23:FER/IwgUxRM/5OI/uXuaRMMpc/or2oOvKlkxybI8sfuVMwVtJziDtWHi
X-IronPort-AV: E=Sophos;i="6.01,189,1684814400"; 
   d="scan'208";a="118774590"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 05:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUdNUDAMRELYYqkbNwXE8XUP3YjRY8MJoOXBG4/O+/UN6+WXssx1uFX3P0k7qE95/1P5lylan2hK7rjML58d7MHXcZ2CUmtdOumDoAqf8uBDVKI8OQ61LF3H8IjgNYw0HtfhzaK/s6/PU61btqP/+dElLH+HtGxFjsAIJQvRvDaFdYajXAZrKstWz+JAM9Ff5yGpoTwLFUnGGMLOWJ1pN8qSakwQNMq4I/35DoI5D8EB/6PryhnyQSU8c8YDrAjf9CPF9osl88JLsYF09JJFrk2aoOJAUj+89srQvBTGpiXurftiD92MqKBeW7BgXgh+nskMUl9Ayy1jAdmX+UmJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEhCFM/Yu4jOnP1Bjd8oBlZQXjL/pVJ8QCtyJtbgV20=;
 b=ayYjr5nbkq15CTmz19tmypO8TAqziIo/H86sFI13bmf7FF5URWQPPFJDv0bsimCOqQU3SnvFnlIp9gSYbswESq+t+O2tZhoOoTLr4NN8qYc1k3okGoR5rXJ2BUwlLt/XtxjWYpGX+10rpfMLd9C1eXhcd9vIP8ai8lElGsXvGs8WNi63xG92JBWC5fMfCBe+kycj77dk3kW6qv0cfZQqeSGmX36ZU3W1ow3YGH/saKkt++FzwKEdLkJTwK8gjlDY0Ok0KCJNnfR53QnzMRG796/3qhDmXf9L0MevqZr5PVDPWuskGVDuTubtLzTkHzPL0dZ/xs5/+ZKknSGicirRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEhCFM/Yu4jOnP1Bjd8oBlZQXjL/pVJ8QCtyJtbgV20=;
 b=wQQ0lm3ly3kBPVgFrbtVeB0mo14w00TVGygVwvPhGSX+qoIK5kgQkEOyQGYS2dvJHn6tp2Rvndqk6U/vYmY+TO8ysysNqLjONH4IvLPoaf9uByh/8Aij+D4UHynYxQ+gYHHpYJ+VUZWzLX7BAM4sxCwUjK7gEnZp2bbPTKy4WjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH8PR03MB7306.namprd03.prod.outlook.com (2603:10b6:510:252::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 09:27:58 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:27:58 +0000
Message-ID: <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
Date:   Mon, 21 Aug 2023 10:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
In-Reply-To: <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH8PR03MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1d4e2b-341d-4115-65e8-08dba228e810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z72gatz2brLKTA5zH3xE1EKeCKgBCpQFz5cdyqhoX0SDzbxx5YulRRrPrUYbihBcnytYy2IDV7Tyeywe9EQ4o4ZasgPo7+V/yPWivUXXXB6QrOEIGnna2bjkSLPfSEyB4tkdIJhspUXt6xv8twCIOMO2tx1yUCJ2757XV7WNqvYLOVv//nOx9lMsYK3EHsFI+OmTYi6y0He0MJ4nHa/d1yGAC7vQpRnscctHHkJnkOLdFuGFrOC+T+432QI0BY5QKq2nOmCBszBP6RX3ltPF/QymqknoV0Si+0xi00SZV+NtvoilwxiMN25Z9NtsJx52shrp4e0ExXEDngpAwyy7zWvBtHIV1DW22XGOOjCliwanK/R1AuCvjPJJGrawLATMsWS0fVTHi+MJ06g2nG/hEAbO26N0dkQqlR+NO2Z8vWi8CLSHnmn2K2M0zdWAuElj9G/aMBC102RoHXOps0jnPdszmhfevfWnqKqqSnRNJrirlJMqPfrmnn8Pf+HZcrBKrjpwys1xGP8rmeUTMqMNf3jd7MSNpn6HRwiZ9HremBIaiAT3mKeXODDaeY4sbFcqq2eThbMf6wh12pr+hQgpjbCqu/T2P05823TQ0/VjA6qRmHlKo0Qnhqq+7ExCYZOvjs0683ysrRYFg1k32zFBXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199024)(186009)(1800799009)(316002)(6506007)(6666004)(26005)(6486002)(53546011)(6512007)(4326008)(2616005)(5660300002)(8936002)(8676002)(2906002)(7416002)(4744005)(41300700001)(66946007)(66556008)(66476007)(54906003)(478600001)(38100700002)(82960400001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRlVUdYUXdGKzJzZXk2YW5IQnR6c3AwT1l3WENyVkhFN3YvRzBqNHh5RHln?=
 =?utf-8?B?bForcWZ3MVJIMWZGeFM4U0hHTTZlU3YxNmNoSWlKU0tTTlI2U0NDOUVIZkxW?=
 =?utf-8?B?R0FlNzkzLzFzSmEvUHR4ekNZOG5obmhZQjNmNWhlcnRMVWFwcGRrNHhCUE84?=
 =?utf-8?B?cUZuUXZvVEsvRmdHQzlYejViT0xaeHJrbzlCMndXQXdTVHZlbURCS1h5ZUIz?=
 =?utf-8?B?ZVdSOUppS3lXYUxSQ0s0azROK1JuOFErZXVCeWpWeFVtVzNSUG43eVp3SEdV?=
 =?utf-8?B?V3FLWFFmTUhWbTBkSTJDOHZ4VGZzSVlGRDEwTGdMTFRPY1RRbUhSUEZUYVA3?=
 =?utf-8?B?QmI4WXNBOW1mdnFpVEorTFRSUHFJTXZxU2dIYjZMZEl6azRDMGFoTTE4a2NB?=
 =?utf-8?B?Y3Y2ak9DbnNtb05uV25FRFJNbmhpVzF3M0tXQWNKVTV1L0VPdHZmT2g4UFdr?=
 =?utf-8?B?b1BsOUNXSk8yRGorS0tsT2tVL05vL2ttblI1bDJWZlZhZ0dHQ2V2WkFPR2d2?=
 =?utf-8?B?cnZ2L1JGYWVVK1JNRU9HS256YlZjaDdCRlg4MHRFdW1iUGRlRjlLL3dlL21s?=
 =?utf-8?B?SzBlRURMU0lKY0dNQmdZMEFpam1HdEhBWVMrQUdBTjUwblBRSW8rQ09YWDhL?=
 =?utf-8?B?ZVNpaDB6cVR1bXAyeWlVUGRPWVB6Z3VuTisydVlnTmFXMUsxc0VRdCtvaXFX?=
 =?utf-8?B?L1czK1BBM3VxNWxmSEJXWlp0SzRMU3p2dksxVmdJTWU1WmI3Y0JENGw4WHpq?=
 =?utf-8?B?aVB1b204OUtKQTU2RCs3V0xOWXRMbWNPK1libXJPVUdQdXdrUGxUYWg4L3k0?=
 =?utf-8?B?WWhjU2h0d3E0clRUWFNobDZMYlVBSHY5Q08wbktwWE5oTHNzTWNRY3Nka3M0?=
 =?utf-8?B?YmJ4b1BnemVTclhTMTBCbnI3RmxXRU1STWlmSzFSQmg5dDJVdksySkRxclI2?=
 =?utf-8?B?RGFTQnBiK2dacWkwZHN0K1J0K2xnN0FsbmlIMGdFMXhmL2ZOdlQ3UlFxOTc1?=
 =?utf-8?B?cjFKbjllVW9uTXdqSW9qSTAzUmY1RGZLdFBablF4Q1VGZlYxYkRxUXZFVUZO?=
 =?utf-8?B?RStUQXpZaGZXQXNkN1BKT1JISDUzd0dmcWZucWdlQSszdWhQbVgzODl3NjBl?=
 =?utf-8?B?eDFLZkl0dm0zbDdBYitaTG1VL3pMSTBIOUdJRkEzTGx5a1AxSExaNVhONTZI?=
 =?utf-8?B?OWN1K2FXRDVXLzl1bEwxY3J6N1ZodGZzYVlpS2lZZklUbVpZOERYMU9HNFlF?=
 =?utf-8?B?NEZGYzhQUEFUZ1FrcDZqaHJqbzhnK1RkeUdLRk00MDdEc1hrTWkyaFhmVjdJ?=
 =?utf-8?B?UW9QbkpkV01jVkp0aWRrakJteStJaWF0bDFxMUdzQXFXR21KK0sveHhBUnZX?=
 =?utf-8?B?WW10TWU1cW5Oc2RldmxscHBsQVNwUEVhRDV3TVhmVFVXT1g0WGVUY2kzWEE4?=
 =?utf-8?B?TnNjdmgzdXFYZGdneWUvNUFoYTRiVFo0VDRHN0Vvb3ZqS3hwOUdPdExTcnU4?=
 =?utf-8?B?V1RrQzdiN291S3NpWEx1RWJvUW0vbG1XbWROM1lQYS84bkRGNHNNT0o2N3Zm?=
 =?utf-8?B?ekdXWkc5dndxSHJUVHVVNXZMdGNLNTVYOWFxSm1pN3k4MFhYWkI4dnNaaWps?=
 =?utf-8?B?dDBuellCSUNtMTMvM01RSEZLQ2RhQmhXa21lZ1h1WXc5dFFXaVVoUnM5NmpX?=
 =?utf-8?B?QnpqT3U2QkR6RWloSllHS28wL0I2NjVNQ3Jhak5md0p0eURRbFVDaUxvQ2FU?=
 =?utf-8?B?UFM5VnBVSXpweE5kTWx5QW1NVFZHMGNzaEJudXNTV2FhM0JpNHpOMmE4UnVI?=
 =?utf-8?B?N2piWkV0dlB2Q2QyOFU2SEV1T2RaVU45bjVwZm9SRGxCbXNWOFdSc3lSUDgv?=
 =?utf-8?B?WEp0cjEvd1kyQU8vSkRQOTF6Y29RTktGY1VGb1QrcGhxNHpKaWhTNU9GWndQ?=
 =?utf-8?B?aTVNb1pSRjFML005MmVDM1hTb2tSLzZ1K1JPa240VzBpMkEvck5yK2dHeUlp?=
 =?utf-8?B?QW1sV2d6aGsrMUlDSUgxQnRFd01uZzBUUHZxZTdNM1VlUUhUVHo4NkJUM2I3?=
 =?utf-8?B?SDMrTm9NeTBrNmk1d1ZFWFRsaWV1UElHN2hTa29kSjJQeUxDamU4VDhweXZH?=
 =?utf-8?B?dTRzRlpEcTJ0RGlLaWpSZnI1RndKQzF5aEtJUlFkS2x3ZFlUVHRsRVlwaFRC?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MUMvSTZhR1REcE9xWHl0T1BBTFRRSlNqSFdpQWRTWlZza2pMM0tpK1JZK3RM?=
 =?utf-8?B?cy80N0t6a084bHpwLzY1Z1IwRkpzalU4NUpLaGFHOEMwOHUxME1iMzVjM2lQ?=
 =?utf-8?B?amdzY0x3M2Z0TXBXMlRvU2FCRVpWVTEzUlRsZWVLVFZNUnp6cUdRN2FkTVh6?=
 =?utf-8?B?Q2NTUXBBNk9HV0hLa1dGeGZkM3N0bUFZRVNhZENtTGppQTRkSXdXdjdyYXQ1?=
 =?utf-8?B?TlN3RHRIQnZFL1o3VkVvL0Nza2wxdmp3V3JJTnpVSlpSQnlWMm15MzdmTU5k?=
 =?utf-8?B?dUdXNUwzaFE2NEhEYnA3cGthZlFLeUxQVkpIeit3RHJONDVwWVpKUW11dW92?=
 =?utf-8?B?NHE1d01CTmp5b1Z1blNwcXlYMGp1M1FTQmNIcXpaRmdWMi8vZXJWWlk2eHhN?=
 =?utf-8?B?bGtqREJUQk84aFpYR0UydlJpdHVVVW5wK0ZNWmt6N3JGY3UwUFJ4S1k3Q2xW?=
 =?utf-8?B?VHc5enozLzRvTWhpdDQwTVkzdTNPRldpdEUzZkdJTmRUckJRZHdaeis4UnpX?=
 =?utf-8?B?bUZlUVdxSzJyUEFmLzlwd2hHNkpIUUl3Vjh0WlU2SDBucm5sUm5lbW0wdStI?=
 =?utf-8?B?K2tab1ltZkkvMTMrMnlwRXNEZ1EzRlZvS0czdDdONUU1MVFMRnlVUFRPZjht?=
 =?utf-8?B?TEZ6Z1ZqemU0TWgxd2tLeE5GaGlCRnFPUkkxamJPVUFqamx6VE1XWmpVZjNw?=
 =?utf-8?B?TXZTNkt2U21WVVlXVHFmYzIwa3ZQc294eCtiYmh0KzN3V3YvVExhY2RCaVh1?=
 =?utf-8?B?UzJuRFVMWUxWQmpvT1FuQ250eHQ1OS9kdk1LSjZnbVNMYWNvTGdWZU1aOUNK?=
 =?utf-8?B?eWlGS1pEMWpEMFh1a1RWZUtmOWtzZWFWLzI5eEJGZEJGOWw1alY2NWFtNmx0?=
 =?utf-8?B?eTZQakFyQlBYaU81Qm93YXpOUjdRTHVvSGNaVjQvY1RNa0RDNjE5cGVkeU16?=
 =?utf-8?B?dVB2T0QySzZTUUZBR0JXUmVGVm1maTJPd2pLSDJTaythVVpqVlVPVmZaZkp2?=
 =?utf-8?B?Zm5DeHVMT0VWYW1VQTZrclJvVEp2ZHYxbnlFdlVrSk1NUW5adERPTUZkQ1V3?=
 =?utf-8?B?cU5kOFdGaGhwd3U1M1gwV2huOW4ySEtvVTlDNFkwbFhoUUplRmdrTkg5SWFO?=
 =?utf-8?B?bWE3TmtLU2lBTy9hdTRUT1lLVGVWVjBYMUtWS3UvbDMxWCtlTUhzT1Byd25X?=
 =?utf-8?B?SllpZUUwTnZWZHZXcThDUUR6cnAxNkcvNmFoWU40b0h5RnBqb2IvSUQ1Q0VZ?=
 =?utf-8?B?bjN5VFRreUU5OWpmUDhIazJyVWxQRUYrS3M2Zm1taVFMYU1lNkVFNFFwRC9S?=
 =?utf-8?B?VDZQdVdReDZDTUFUa1piYzVNeTI3SDF3RDMzMWlnWm5hTXhrVnZSdUpucEpR?=
 =?utf-8?Q?zuZElovMBIgF71ohBZrY/y3YCpHE4Ga0=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1d4e2b-341d-4115-65e8-08dba228e810
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:27:58.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR4M4/eNv+5aZi5Aw4jvIDTSo1tPECuPwjvQwP6bjbGJPnQXnGlhbAojSfnaxRQDoXdHolYHrx/CmpE151ZRc1w1QuBCoVZfJIFd1FT1ycU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7306
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 2:18 am, Josh Poimboeuf wrote:
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 7eca6a8abbb1..b08af929135d 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -766,6 +766,15 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>  
>  	if (cpu_has(c, X86_FEATURE_TOPOEXT))
>  		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
> +
> +	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {

This patch is necessary but not sufficient to fix the bugs.  There needs
to be a !cpu_has_hypervisor in here.

Linux must not probe microcode when virtualised.  What it may see
instantaneously on boot (owing to MSR_PRED_CMD being fully passed
through) is not accurate for the lifetime of the VM.

And yes, sucks for you if you're under an unaware hypervisor, but you've
already lost in that case anyway...

~Andrew
