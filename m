Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6A785B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjHWPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjHWPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:13:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A429CEE;
        Wed, 23 Aug 2023 08:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFSRINREr6Z1Q2uLccdyvUhUGAb+4OZVy0x0F2Bzk5I2s+/1mhxkYVKWVCkDf5eOf8+7ojDwrCsrznSLOwW80bAN8W9r/H5RPpzPf5CKBpgk367VZQ81iYuKSQryNdHditRCussQumRQBgn68WA1hA587hvVzlH9jbPqKHQv8RakuEYtiD5C69O3wDfAsf0z0/5DgzCuk9YE7tLPAHrkUlcaxtkiIftRUbXpIHMe8Wq9Og5Z9ISCA5BgOLqMv0FSgXEUuFsGt0mDfRA2FfKEs+4IrWcgCIMq3AR0iJXLjwQL+2BR1BqREqhvJizY39NUlNR0HEmYcQBU1bugXJ4Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7vxKkfbS8CATb9F04KQ+WJkxKbrg+RQCr898MdMrQ0=;
 b=eEw/lytW+fwcszMjh1GOY+obNKipLfvXVO71pA+PA7Wgt9c2XrWxAEWQpg4t0OG836NosFZy9PcydDQpn0dFOVh8/g8W7e3ORarFxfnbHIREzRpoLaTUkoy39XusPEjlS5ckprJCGzjtHj25MUxdLdDPt14+UYbMLAbyhhAIMnBKgbPoi1u/1DJh/EZVzV4vWWqldAsWQ4eJq5AYcZLpWXvVXUh0ul3UGd3+9nb6jeXnhQAyqvd1mk0q/S22EKVNK5eLgzF7QWRyJTLRPmvlMUCLYxY4eULnBl9epMWZ6pdNLkFymcatI5JN9fOPNI7GI7rrOVGwssTbYnVspYnDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7vxKkfbS8CATb9F04KQ+WJkxKbrg+RQCr898MdMrQ0=;
 b=ITTWlJp5n9sKJjYzIQXWEqcN/4Xfo6bDN1FUwl0md4fNQfdQD8yhSCIrv6v9uLRwZzETwFf3bMh0UncmLAhdmtfaWVciPGI0lez7FLLT9wTumejXafsCJASv3WxzhmEIwrgVrO4cRjhNS/7Ugr9kEK+AHPM7DqO64GzwwDlL3Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:13:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 15:13:04 +0000
Message-ID: <9f40d321-392f-5cf4-a3d0-df9c05500f50@amd.com>
Date:   Wed, 23 Aug 2023 10:12:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 0/8] x86/resctrl: Miscellaneous resctrl features
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
Cc:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <TYAPR01MB63301926FB80440DB2BA1C058B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <TYAPR01MB63301926FB80440DB2BA1C058B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1539b693-e988-4dcd-715f-08dba3eb727d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUvXA+qlKkMtWOn8Sx2w06Ym4pNxDlQ83Zte6vAr+1gEINfeNwXtlMVVKExK8M73V5CNF17b9BnkEsKbrg941Wi9y1xhqgxu82y2z5svSCE7UU8I4xJkttreLykQ1HCzPjpLmy9gouoAWY/5F5QIK75unmidZbg/8pVbH7aVXUy/IQlW1nVb1riJX1NkhURQ2cVhBaSAxAei1xnK9ZfLbKTfFQo8gAxqcRpZbGZQU5ssHLSYcvTbD0MmtMYxVKs0Ibj75klQ9z7c7BHWsQr3hxafLXvyDVZCv2ln6qH9xcLq5KWlzDVIPNdWKyojPFK0+oHbBZ4jRLi2ZCMwepurkdBY07SKOPOHd3BCP4XSJrDn+5EzM2ks3nKW1tVup3HJLVUjm0XPzvOPDoj6MDa3fl9OVFu135k5EWJwwUeHZ75J4rWELU5mR2BeQYb6i/ABXw49ocsl3Ah0pgyuWJ9vBq//tTqAefSRLuoFFJUVaunF3eb6bK642MaLGD4qg9eBwDYY5BdNxp3QdtTQg4EcXKZT6en4uTt898uZrJqB+xB6mVd54ouPHE/rQ2UDlRMvne+xnFVcHBLEGoDXluYwKjghubw45hnfrX0cN9vN2n4KRXxDL9i3UzaUWnK3f7/jd/7JEvu8fdpGyq6kSklnvVi/ZS6+d5DR1XQ1nwHUJcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(3450700001)(7406005)(7416002)(2906002)(316002)(6486002)(6506007)(66556008)(66476007)(54906003)(53546011)(6666004)(110136005)(66946007)(478600001)(86362001)(558084003)(36756003)(31686004)(5660300002)(26005)(2616005)(38100700002)(41300700001)(31696002)(6512007)(8676002)(8936002)(4326008)(491001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE9NK2tLT3Q4dmJLVyszMmphM3k2aUc1VVpEOHJSTGhEMnNYZzM0SDlDOWVO?=
 =?utf-8?B?K3Rza0xzM3lValB3OXhXemQrbC95ZUxYQk5WUng2bmQ4eVQvZitQc3d2ZDJ5?=
 =?utf-8?B?OFlQYnNjWlNGTllWbjlNaDFhZmdvamJGQVliM1FKdVlhL1lsZC9vOVRxcG9o?=
 =?utf-8?B?WUdvcjJ2K0RwREJEOHQ4cGxwU3RLZ05hMERLVUxQa0N4Zk4wNEpXaTlQMlV3?=
 =?utf-8?B?d1Y5OUdUajdBK3g0VjdMYS93a1VGaDJlRjJoU1RzT0o1cnlBZzV3WnRRRXdG?=
 =?utf-8?B?bHZpVVhKOW1id1NqTGRPRS9wTER3KzhUSk5Ga3BPbmVpYVJOcElhS0FCNTZH?=
 =?utf-8?B?SVMvTGpCc2tnY1pSNWZxalVZbWtJNkRMTW9EWUpwanI5NytCanB5alQrYXpi?=
 =?utf-8?B?OWhlTy92cWswUUhQdTQ5Z1hDcGpnNEVwWXZLcEEyZVQrQkpkYXdoRjVkbEpR?=
 =?utf-8?B?UExmTDBFNXpwRGMydnhhcjVCSHc3YnZuUTduMUErS1UrZHBLcFYySjhmSlhH?=
 =?utf-8?B?S0NkekVQckNNQjR4RjlDVUNGd3kreUhIcDlUWTRiMEFIaVBlbStNamozeHRa?=
 =?utf-8?B?V1dBenk5ZGR4bjlYMURJblNFcU9UeWtYU05xdmJVUjdPM3gvK05vWWpqK1BP?=
 =?utf-8?B?VEdNY2xPOVhiN2pVVmxxNWlGM0hLVWFsVW82aEFvSSt1Z3g4TS84MlN4YlZG?=
 =?utf-8?B?bzdCYzdra2RTNWNwUDZmYjNXZm5tQXFVemlqaElMTnpQb3NNbUNMTExqNHl6?=
 =?utf-8?B?MURYYnpzdzN5d2pXUmhJZ09uQkcveFpkTHlvMU5SMHZYR2hpcThucXZhV3lz?=
 =?utf-8?B?Q3pLQmZjblI0NVp1UmZUYnlvdkFGVjBhdXlrNUhKUGMxbFhxbEdPWURITlpG?=
 =?utf-8?B?cWUrNitsOEpLa0tkWWNTN2FCVjNnbW1LdGNldWcvbXJMTXZVYjVuZkFKbTMx?=
 =?utf-8?B?YlVmaHNEdkdhQUNYT0V2QkxRaXp0Rit5cmZMVGRGVEpSdzV6Ykd4NGhCRlFC?=
 =?utf-8?B?MGRFS09GMk5uVVNHTEx5dUlzelZSRWZoYXoyYVlpblNyVU1uSUcwVWhQZ0lG?=
 =?utf-8?B?R2ZPdmRWbGZhM1hNc2RnNFA1WkJtd2pPM0l0QzBNeXdaalZiY0J3RitjZUgx?=
 =?utf-8?B?N1ZiSktEUlFuMnZJNFMxUERCSFh2TmxTT2VxbnhDeGpqQUtycUxpSksveDdG?=
 =?utf-8?B?ek9tWXRBcTUwNmxZUTVlNVoxODlqVXJpeGN5T1dwWi9mS2dQYThkb1RvWkYv?=
 =?utf-8?B?MHlpK1AxNDZ0ZjhiQTFZTVF6aDRDbml5dm1zODBzRU5zaTNOcmlNdTY4bjFM?=
 =?utf-8?B?aDl0N3RTMzNvUDZiMTRCcThaZUxIUDEzYys3Y250a3FMaVU1WW5uWG5FOXNR?=
 =?utf-8?B?K21JTlllakEyTWdKY3RhZmVwdXdsSU9icVFKU0FMOFhFZHZ2aFBVTy9MTVgy?=
 =?utf-8?B?djFiTTBWVlFlSXBHQW5RQkVXNWdiZW5PYmxaSlduMER3c3U4U1AydDZmcTNw?=
 =?utf-8?B?TGdmbnlERjdNQXFISGNDQmpyeG9YUHhTb2lYelFMMmxTdXQxWmZJanRYem12?=
 =?utf-8?B?cEtjQUtHeExZc05SSkEwRWlHVWtEeTFXbndHR0xORlV1dGVRaEhDWHA2TWZ0?=
 =?utf-8?B?NGpCdFhxdkVIeTJVU2t2LytLM1RqN2VQSXpLa0t2NE5GOTZwMkpvdUp0b0No?=
 =?utf-8?B?aG1pSVBiK3VUUTMwTGdVUXdWVVFlbWhTNnNsRml0bmlyNkdNWUkwN2J6NmpX?=
 =?utf-8?B?VFpkSmZoMUZLRFVSTUtqVXdLV3ZJekFFcmJqcTJCSThsODJ6a1N0c1JGMjNs?=
 =?utf-8?B?RXEreTUvZG9scXkwQzNvZTYrc2NqQ3duQThNa0QyQTQ5Q2toWk5mUUJkYXkr?=
 =?utf-8?B?alBpZzY4WklkQnFNNWk2ak9vc2V4Wm8rTjh3U2VlVjFjcmhyajNRSVBrQkJR?=
 =?utf-8?B?UXdCWE1KUUhaanlWRDJOWFhjVHlnbjM0SnZSa1RseU50ZkF2bWpybmhOL2dh?=
 =?utf-8?B?eTIvTmlnamFKdHFybHM5bEJLamVXbUFLZk9XVDBENkNUNHRKWjlmV1A3VjJ6?=
 =?utf-8?B?Wjd5aFhQb0pKbzF6VTMwVVMxYTR0Wkg0UkppSVpmSXIzRGpWaUhGR01jdXhn?=
 =?utf-8?Q?hFik=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1539b693-e988-4dcd-715f-08dba3eb727d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:13:03.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYH9zTVp45Z1PycsNXDRHzezIbQ39MJvUSS8HjZeV/tEklUQxHmXRIHasIjdPpE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaopeng,

On 8/23/23 02:06, Shaopeng Tan (Fujitsu) wrote:
> Hi Babu,
> 
> I tested these features and ran the selftests/resctrl test set,
> and there is no problem.
> 
> <Reviewed-by:tan.shaopeng@jp.fujitsu.com>
> <Tested-by:tan.shaopeng@jp.fujitsu.com>

Thank you
Babu Moger
