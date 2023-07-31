Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEC76A08F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjGaSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGaSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:42:22 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5AC2100;
        Mon, 31 Jul 2023 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690828930; x=1722364930;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q2GbTjBezCjDg1RSdHSwVgXx5BvQYQSYMVcJOznHplg=;
  b=Qzd+b2Ik+LJU51JlY/mwvoIItLieMn6cjhLGBAyKSmj4hC4NuhmeDSRR
   PnZ+qZj3YztQObrpu/J1t6W9vCrk4VnmMuU0y6LGrhVrDlaxEoNhIuwZX
   10aZiZBXPqb9MEU61hLDDKM3zRzN6+SGhULkM/ztbEMbcb0lrnamt1HtJ
   fNzCDqIDd8aT6W5RszgI6j7SYcbTIUU0zKAK2fCUL6CegyL0QE0DL9ik/
   S4yXDfD3/Rs1wZbHO/cHeXBnPpRVnCvFvXTSqrQvFCLjhunOtHVA2QzhC
   QfhCfFKxUOYitSpZsodVd/xGe8Xh9UQvgMPD92RtjpNyc2J5yUBXcbOQz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349396674"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349396674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 11:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705528062"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="705528062"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2023 11:42:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 11:42:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 11:42:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 11:42:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 11:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHe2YTjjHOuGdBojAggHFmG2+f+BTLYRDEI/WU+XDIylmjT4vi7un5gUo/5+fmYNWcXbRCiLmL8/xqbBg46R9P9cGmSxeDjybVpsqargp9Yw1DXdzcQ2OEAik5ZiXfGHpQiJyeXPoM5ZwX3Fkx3qTmXJ/mAVzjIlPOFqr8i498w5rWLP0giYDmFnb/yKo0sSS98P0eBpKgHpyGvh9Mk8OMFR5FvM8NbJ5cbypvJ9t9rnzdqLZu5KrIR8UK42if4U2nvrrmqZaKNl7zT5AzV7Cotsm55KPuBitMyz/eVN4D5kWZnq96H9wjartfOwMj/kqGBtAWPliLhN7Y/XU1COuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOwoEJmqY0q5NNFmPj4Mo1rNM8IKkrk68uNL3JSA9BY=;
 b=FVqIRJcfrh3u2+VNzJk4QpghrJ/sI4ZB9MMDQ/OCYDJDvP9M45WLGgLMC+9nF3ynkAU4oFW76ioI/Nw3MwJ1NEVqE3HRga+DQ5iYhL8isHWuLjygUZUEvJhlj/u0RJ6tpXE9Lei1BLufFBufnhCOpTMsYwFVtkqOIYcCh69MPl2jdnLO3TZT8w/GKHD1NWqnV22KSs09pVUVCSMuj3YT73p0LCLwcpJ6C7EIV09vLE97yCI0FQF/xtD1GcLzLFoo1JoyXHEM8PfgN+3jYTvYYxc2S24lmqL8a8hfUtzAsPNd3QW93qm0xoSMqwSh0qL9ulE+syEOaTAXG7nyeBuHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 31 Jul
 2023 18:42:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 18:42:03 +0000
Date:   Mon, 31 Jul 2023 11:41:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dhowells@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
Message-ID: <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 04329051-9846-4978-5040-08db91f5d50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySt1Bi91WTtEh6B/P6b43/hibwBwttYnR2bMHGnBK5xbbSvQYHjCz935WgUc6R7eGNrgeZpCt7L0A8D0z2aqKBVTThZWuGMey9p5vc4IHdQIwm72HMVbJstv7hLc6zHHB4GEvxH4QUZWv0FEd53MxXfOW+iw4U52hAOvnOOf8Wilzh8ldhKaDvmKBLdSoetUXjA1sxYEs3Uoe7ly4oUdWNTuKZgwTVAeJH6ctwjd92gS+wSUVDUd7gpKzKvqInh0e577xQtg8pJXuctYymJvVEYn00z+yBuSkC8qB8Zihv3omXmfPW3PnvVUeOdGYRdyvXcaMD87Ppwk6CgdY/NNK61L1hG5zE1mbn/tQvjdTUI99prKKKYmf0F8mBOxX4DP9RcxTzIusDJJu0aYMMN51ebXhJgfo0NdHAdgFmkuBtsX+icYt1hzdb/duF0UnoH5bC0121i97XBMHlT9WyL6ut0QTo5/m2Ds2dzo7tmdIikL3ukdYUiujDeFSuGbdeooqiEsb/7LndEtnwtIIkpf+Apcd5j/7GgxXMIFo9D8yeIQGxV8+5o/zIje11w9PizR3npjRP53oPOoIA0MZN4oYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(966005)(6512007)(9686003)(66899021)(186003)(26005)(6506007)(6486002)(53546011)(41300700001)(7416002)(4326008)(66556008)(66946007)(5660300002)(38100700002)(66476007)(8676002)(110136005)(2906002)(8936002)(30864003)(83380400001)(316002)(6666004)(86362001)(82960400001)(54906003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnY3WWc2dGFBN0ZsVHM0NFRYRVhRb0dtekUzaDhwZ2s1Ly9oRmtpNldLSnNl?=
 =?utf-8?B?eUVYcjQ5RklQRzdBV2d3cUFtaWtBVm1ET0xROER1ZUFHcEhrR05XQlhnSEVP?=
 =?utf-8?B?WUNqS3RrZUhSWnhSczNoMU5HOFVoeVBDTDJCNVNjZm1UWmhVNE40d1dJUk5L?=
 =?utf-8?B?anlEZXBpZUJqVFcyaEdocjkxemwrZkU2N1NsZ1VxM2VtQ3FlS3VqYWk5cFZX?=
 =?utf-8?B?Z0pTYXVhVVptZE5rZnI2dlhDM1dvcW9JK1JWR0N3YlNUeW9RcGtpQ1V6VzBz?=
 =?utf-8?B?MGdhQ3BGY3loL1RhSlZVUE5JR25sMm0xd3h2ZTVsdUY4QURPempWMWtEUEk0?=
 =?utf-8?B?OUlhRWFjOFNNV2sxY1c5cUVMM0xKbE0xcGNOeU56UU9uMnZ0MFNZQzF1V2ZB?=
 =?utf-8?B?MzMrVlRWWURUVC9LZldtU21HL2FRQVVjbHZFRHVQQmw1bkNqVlJMeThxKzlT?=
 =?utf-8?B?d1JMcFR0SVI1MGxmNGJXNE1ZeVZRZTlEWVM0OFQ2d2dWcTJ6a0gzb2tGbDZj?=
 =?utf-8?B?ajRoL2p6RU0xMDJaWm5QTDVBMnVUb2F6NVVRNXh1ZXBBd1JBZzVWbVloM25i?=
 =?utf-8?B?c0VBOU1MMTFPa3FSVVBlbXhPOVRIdEI1OUorcHBNZ3pqWkV4cnpDejR0czF4?=
 =?utf-8?B?WjN2MjFrK3luZWpVQVBYbkdxVENqNENTMDJiR2R2MXJoM1JIS1BnaXdmQVNM?=
 =?utf-8?B?cElxK1lFc0ZwSTk2aTlQV2ErbjFlVjRnRDI0V21jNU1RakdVUjU0NlgrNldi?=
 =?utf-8?B?VmxkR2RXZTZubkxNMXFUWEZLN0lsTE1EZlFsVmVvMkZKd0kvQ2l1NFJ5dXgw?=
 =?utf-8?B?d1FQL0JIcERLcHpjNzV4SUx4ald6ZXRPQnZ3WmVZb1BleTh0ZVZMWFBjeGJt?=
 =?utf-8?B?YTY5d3hON1QvN1dLTDcrODdOdFVKNGt3WGZiU0o5cnpYZzJlR0Zaei9CMVYx?=
 =?utf-8?B?YXg4VWpLU1l6M1JRQXprcGtILy9QKzNkam5la0lFbHkyQXdjbDMzakx5c29h?=
 =?utf-8?B?dktocHlwVXp3MHpmRmtOeGJxb3hCbWZpd29uTjRUNUZyS3FNc2toUGN6UGdT?=
 =?utf-8?B?WmpLMVlBeStUNkR6RkFla0xCM3dCUVU5THZHTEZLay9OS1J3NGVlcFovU2Nk?=
 =?utf-8?B?b2Z3VVFPL3JXR2xLcHBQWU0ralUwRmxydWM4cjkyY1JJOWUvbFl3U3pSSUxL?=
 =?utf-8?B?bldsRHMvNDU3YlVmajlsaEZrNGN4S3Y3YjV2a0l1VkJzWlFyM24zU2NLZW84?=
 =?utf-8?B?T1l0S2tBT01HUC9LTU5EV203d2pXMHJwSmZuWlpBcWFmY0x1ZFZsU1Mzbm9C?=
 =?utf-8?B?MHZoa2t2MHlxa3Q5aGkzREdpb1VBcTRhSHZtMk0xZFBzUmwrTGpFVzRIMy9V?=
 =?utf-8?B?M09obEo5ZVBmZUlma3c0OWQrblA0MmpUR05BVXhZVHB3NDdTWXJ1SE0wVkZ6?=
 =?utf-8?B?VnBWYXI4b1B4NDdnWVE3djkzZVhnVThPQ2kwdUt4SFdRTVRpdlJndnB1TkUz?=
 =?utf-8?B?R1VIQ3kzS1p5S3ZpUmNESS9mcUc3WGI4cUpzbUVCUTduVVdVVkVTWVl2QXdG?=
 =?utf-8?B?UFY2TGxhOFcwYm9lemdRNEF3YlVaaGFzellrRjBuV2VFR3ZVU1ZveWlSdEpO?=
 =?utf-8?B?MFQvbUQrL3pSQ0hlTitLWndxZ0p3NVlEZ2V4UHY1cUxQSys0RFpPNnVQNUtq?=
 =?utf-8?B?WWZ2L3dCT2IxQ3NjR0Y2UDVPN3FGYTFhWnBhb2lmV2krT2oyNkxYaGpKeUtq?=
 =?utf-8?B?S0RYNGZTSWpXZER3c3hXMlo3bVVRMG8yRk5Fbi9YQkIycUc4N0VQTVVycERn?=
 =?utf-8?B?UUlXQldpSXk2UTBWSkJ5cHJWQ3R4YkphLzFXY0t0SkgvSHVWSFIrb24zRU4r?=
 =?utf-8?B?N2llTmJiMGkvMXZ5dXdIRjAzNDlVWEJncFJHUjNTZEZ1QUZER2R0N1Z1VElq?=
 =?utf-8?B?WEx2TDlaVGY0d2RqQmc0V1ZDK1hsWmZzcUZSaEV3VW9Fd0hzWkJEeVo1OEpP?=
 =?utf-8?B?anBZSGdyR1ltZ1k2OGRQYTY1bGR6Y2dVVEllRkdwQXBNVmpvcVk0bzZGbUFy?=
 =?utf-8?B?L1g1dWkzWW43N25rcVBoTkNwQ09jalhVNm9JSEVrTkYycUowY29Jak5VNHRN?=
 =?utf-8?B?b0gvdy9rb0kyejdRUGowbEpQZG5QTm9ubHd4TFVtbWw3bFoxSDZwaEdCV3BN?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04329051-9846-4978-5040-08db91f5d50d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:42:03.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzrjanCzbaUH+9uqwVNfXskSmK93oO4UtSuKCEwWqgNZB+6anZzFgjo+mgB8KR2DWpGfQi0ESmo8Q7nGHRMfOJl0VcNHLNCKvpRdU2Ioxbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Mon, Jul 31, 2023 at 11:48 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Peter Gonda wrote:
> > > On Fri, Jul 28, 2023 at 1:31 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > One of the common operations of a TSM (Trusted Security Module) is to
> > > > provide a way for a TVM (confidential computing guest execution
> > > > environment) to take a measurement of its run state and use that with a
> > > > key-exchange protocol to establish a shared secret with a third-party /
> > > > remote attestation agent. The concept is common across TSMs, but the
> > > > implementations are unfortunately vendor specific. While the industry
> > > > grapples with a common definition of this attestation format [1], Linux
> > > > need not make this problem worse by defining a new ABI per TSM that
> > > > wants to perform a similar operation. The current momentum has been to
> > > > invent new ioctl-ABI per TSM per function which at best is an abdication
> > > > of the kernel's responsibility to make common infrastructure concepts
> > > > share common ABI.
> > > >
> > > > The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> > > > more, is to define a new key type that produces a TSM common blob format
> > > > and moves the vendor specificity inside that envelope. The common Linux
> > > > definition is:
> > > >
> > > >     "<hex encoded pubkey> <blob descriptor> <hex encoded attestation blob>"
> > > >
> > > > This approach later allows for the standardization of the attestation
> > > > blob format without needing to change the Linux ABI. TSM specific
> > > > options are encoded in the frontend request format where the options
> > > > like SEV:vmpl (privilege level) can be specified and TSMs that do not
> > > > support them can decide to ignore them or fail if they are specified.
> > > > For now, "privlevel=" and "format=" are the only implemented options.
> > > >
> > > > Example of establishing a tsm key and dumping the provider-specific
> > > > report:
> > > >
> > > >     dd if=/dev/urandom of=pubkey bs=1 count=64
> > > >     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u
> > > >     keyctl print 280877394 | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump -C
> > >
> > > What is the purpose of this report? What does it prove to whom? I'm a
> > > bit confused because it doesn't seem like there is an ability for a
> > > remote party to participate in a challenge and response to introduce
> > > any freshness into this protocol.
> > >
> > > Also shouldn't the report have a little more context into the key we
> > > are signing? For instance what type of public key is this? And what is
> > > its purpose? In your example this isn't even a valid public key.
> > >
> > > >
> > > > Now, this patch ends up being a fairly simple custom-key format because
> > > > most of the follow-on work that happens after publishing a TSM-wrapped
> > > > public-key is performed by userspace. The TSM key is just one step in
> > > > establishing a shared secret that can be used to unlock other keys. For
> > > > example a user-key could be populated with the resulting shared secret
> > > > and that could be used as a master-key for an encrypted-key
> > > > (security/keys/encrypted-keys/encrypted.c).
> > > >
> > > > While the discussion that led to this proposal hinted at a new
> > > > trusted-key (security/keys/trusted-keys/trusted_core.c) type rooted in
> > > > the TSM [2], more work is needed to fetch a secret from the TSM
> > > > directly. The trusted-key core expects a pre-established secure channel
> > > > to seal and unseal secrets locally. For that reason a "tsm" flavor
> > > > trusted-key is saved for follow on work. That will likely starting as a
> > > > wrapper around SNP_GET_DERIVED_KEY.
> > > >
> > > > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > > > Link: http://lore.kernel.org/r/CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuEkpnehB5U7D_yw@mail.gmail.com [2]
> > > > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  include/keys/tsm.h     |   71 ++++++++++++
> > > >  security/keys/Kconfig  |   12 ++
> > > >  security/keys/Makefile |    1
> > > >  security/keys/tsm.c    |  282 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 366 insertions(+)
> > > >  create mode 100644 include/keys/tsm.h
> > > >  create mode 100644 security/keys/tsm.c
> > > >
> > > > diff --git a/include/keys/tsm.h b/include/keys/tsm.h
> > > > new file mode 100644
> > > > index 000000000000..61a81017d8f5
> > > > --- /dev/null
> > > > +++ b/include/keys/tsm.h
> > > > @@ -0,0 +1,71 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef __TSM_H
> > > > +#define __TSM_H
> > > > +
> > > > +#include <linux/types.h>
> > > > +#include <linux/module.h>
> > > > +
> > > > +/*
> > > > + * @TSM_DATA_MAX: a reasonable max with enough space for known attestation
> > > > + * report formats. This mirrors the trusted/encrypted key blob max size.
> > > > + */
> > > > +#define TSM_DATA_MAX 32767
> > > > +#define TSM_PUBKEY_MAX 64
> > > > +#define TSM_FORMAT_MAX 16
> > > > +
> > > > +/**
> > > > + * DOC: TSM Keys
> > > > + *
> > > > + * Trusted Security Module Keys are a common provider of blobs that
> > > > + * facilitate key-exchange between a TVM (confidential computing guest)
> > > > + * and an attestation service. A TSM key combines a user-defined blob
> > >
> > > Are we limited to only doing key-exchanges between guests and
> > > attestation services? What if some user would like to handle the
> > > attestation verification without a service?
> >
> > From the kernel perspective it does not matter, it is just marshalling
> > the quote data. I assume local attestation could be built around this,
> > but that's all user-space policy.
> 
> Makes sense. Can we tweak the language of these comments then?

Will do.

> 
> >
> > >
> > > > + * (likely a public-key for a key-exchance protocol) with a signed
> > >
> > > key-exchange
> >
> > got it.
> >
> > >
> > > > + * attestation report. That combined blob is then used to obtain
> > > > + * secrets provided by an agent that can validate the attestation
> > > > + * report.
> > > > + *
> > > > + * A full implementation uses a tsm key to, for example, establish a
> > >
> > > Should 'TSM' be capitalized everywhere? Or does it not matter?
> >
> > Probably should be.
> >
> > > > + * shared secret and then use that communication channel to instantiate
> > > > + * other keys. The expectation is that the requester of the tsm key
> > > > + * knows a priori the key-exchange protocol associated with the
> > > > + * 'pubkey'.
> > >
> > > Can we instead be very specific about what protocols and cryptography
> > > are being used?
> >
> > Again this is a contract to which the kernel is not a party. The
> > requester knows the significance of the user-data, and it knows where to
> > send the combined user-data plus quote to provision further secrets.
> >
> > Not that I like that arrangement, but the kernel is not enabled by these
> > TSM implementations to know much more than "user-data in", "report out".
> 
> Can you explain why using this key API is better than the ioctl
> version? Is there an overhead to adding keys?

Setting aside that folks that have been involved in the Keyring
subsystem a lot longer than I are not keen on this usage [1], I expect
the overhead is negligible. Keys are already used in RPC scenarios and
can be destroyed immediately after being instantiated and read.

[1]: http://lore.kernel.org/r/c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com

> You could imagine some userspace application that receives RPCs and
> does some attestation for each one, would adding then deleting a huge
> number of keys present any issues?

I can imagine a lot of scenarios, but reading the SEV-SNP whitepaper it
seems to imply that this is a launch-time one-off report that
establishes a channel to convey other secrets. So my expectation is that
this interface is used to bootstrap a guest and never again. Are you
aware of a high frequency use case for these reports?```

> > > > + * The attestation report format is TSM provider specific, when / if a
> > >
> > > I'm confused about the TSM terminology and what a TSM provider is. Is
> > > TSM the confidential compute framework of the vendor? So for Intel
> > > this is TDX, and the TSM provider is the SEAM module?
> >
> > Yes, I borrowed this term from the TDISP specification where the "Trusted
> > Security Module" is the overarching term for the confidential compute
> > infrastructure for the vendor. Yes, TDX + SEAM is a TSM and SEV-SNP +
> > PSP is a TSM.
> 
> Thanks for the explanation.
> 
> >
> > >
> > > > + * standard materializes it is only a change to the auth_blob_desc
> > > > + * member of 'struct tsm_key_payload', to convey that common format.
> > > > + */
> > > > +
> > > > +/**
> > > > + * struct tsm_key_payload - generic payload for vendor TSM blobs
> > > > + * @privlevel: optional privilege level to associate with @pubkey
> > > > + * @pubkey_len: how much of @pubkey is valid
> > > > + * @pubkey: the public key-exchange blob to include in the attestation report
> > > > + * @auth_blob_desc: base ascii descriptor of @auth_blob
> > > > + * @auth_blob_format: for TSMs with multiple formats, extend @auth_blob_desc
> > > > + * @auth_blob_len: TSM provider length of the array it publishes in @auth_blob
> > > > + * @auth_blob: TSM specific attestation report blob
> > > > + */
> > > > +struct tsm_key_payload {
> > > > +       int privlevel;
> > > > +       size_t pubkey_len;
> > > > +       u8 pubkey[TSM_PUBKEY_MAX];
> > > > +       const char *auth_blob_desc;
> > > > +       char auth_blob_format[TSM_FORMAT_MAX];
> > > > +       size_t auth_blob_len;
> > > > +       u8 *auth_blob;
> > > > +};
> > >
> > > How is freshness incorporated into the key exchange protocol? Wouldn't
> > > we need to do a challenge response between each remote party that we
> > > need to attest the provenance of @pubkey too?
> >
> > That's left to userspace.
> 
> But you haven't allowed userspace to add any data into the quote other
> than just the raw public key.

That is not allowed by the SNP firmware interface. The only input is the
64-byte user-buffer that the SNP whitepaper calls a public-key.

> The current sevguest ioctl allows users to pass arbitrary userdata.
> This would allow for some nonce to be included.

It's not arbitrary user-data, it is only meant to a pubkey per the "VM
Launch and Attestation" section of the SNP whitepaper.

> At a highlevel I'm not sure why this is better than each vendor having
> their own driver. It doesn't seem that difficult for userspace to deal
> with these systems given userspace will need to be written carefully
> for these PKI protocols anyways.

The common facilities can still be made common. Namely, the interface to
take in a pubkey / user-data and the location to pull the report need
not have any vendor specificity.
