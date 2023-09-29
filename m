Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABC7B387A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjI2RSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2RSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:18:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE35139;
        Fri, 29 Sep 2023 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696007927; x=1727543927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5257t2t1qEGOst71VeXv1vR9YVagQPPRI8hywFZgAKA=;
  b=mzNAFHhaTDsDKWZEjRN/ktWRkbr/TWmnLlKxOHEPFrJefCLisLS0FloQ
   BTDiw5OPVB4keip50osK7IiszmcruU9ZpyyuP3HeoDMwS0GXQLeHz3ejv
   HE0ip6ywZFDyDM1gEQyuYsO/zEecKz7DzFBe66xSWnZP24nyt58nH/AQ7
   7PcVICmLXEEBHzWRRgTC813UQXj1y/L2Mrg9WuT/a1UQld5CCGTPSNbzY
   Wj0fqmySOgCnX8cDXAN4XZb83+QSbN/Tm4VGcWNrpR77zuQyqPZ89Z+ld
   SIOxPKi/6bPItkufCIR/dA4ux9qHMYidEimW8/Aw5D314YwgdIQ5qI3tw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379619545"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379619545"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="911267"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:18:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:18:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:18:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmvOQGf8RTPl/aEHHi1/UhpUNqGIpUG9nTcLt7DuAO1x82L5z3UPYv9JZV5L+laHImj491GnpXcyKwGzcRjBhG8No6XcMA5hSpvKf8T5hq0daNji2xNs9d/8LlTGF5sqmyCaDYw1xc43o54ALLna5paN1MgKE0pw5WzTrzRGySBpi3nFQRnuXojK92sscB8wZoVTOZ/6je/d6sOXy7vg+3rUoS4wOWnZM4lMHtjZmff1lSz5sVQck4lgeLlT8IcXeEFfD/wUt1Z/Hknspx3BFShXqNMaIl3e1yTF/QOdDxIFoCK7eYFFfuL4Ef0m/HPygnpw/gHi4QStkVriDTQTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVITdsmQ+y/AjNaVQONtR7pYklo1F1nx946Wy09uBN8=;
 b=nxfr3QswCU94vjocDnW8NrYehSnkBNEa4fSG9B4VOz7M6aUlzs1yYxV5TrpHzBSYosadEGnPRvY2c7SS/+msP+8px7dfWCtJe9z5cJRoH1AvOR4XCIzc2daeegoTd0bqnBgTI7dP6ho6qHyCb6+x34ALmtH4YhGLfYPqPjavClK74xUVmh3APijOhtqi+VRId4gp5cukTgpCSAda0M3gE5Ky1dY9WGJHsqY2UgjbnuAAjUeZLU5FuClm5Xo8HBcv9KXlTvs8gPplSGlb9AipEro65ZL2VGy4pmEMlZshMKMHOWRMQrNpVwNn+hR2h+DIhOEFvuC7F4iRRAzpRgtuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 17:18:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:18:44 +0000
Message-ID: <01d3a02b-7104-efe2-15a9-b62f85772ddf@intel.com>
Date:   Fri, 29 Sep 2023 10:18:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] cnic,bnx2,bnx2x: page align uio mmap allocations
To:     Chris Leech <cleech@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        "John Meneghini" <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-3-cleech@redhat.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230929170023.1020032-3-cleech@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a7ed42-cb79-453f-9eda-08dbc110223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBWl8ts8JCvXaT4pN+YoH5ANn68H+ZElTzGuT//V9THBcyg6BYdR/CmTwpWifICkQ6POf3zEDwticHUwHrjqnn0CTbAsHf1pZvbi9VpfIgux33RCwOCS5a5S3opsLRv02Nm2hRKvLBg0kHdMHrP9yxx7itjkzrSWzS9bqZGp/PCdYoGTflm3cjyZmg3EX2xAn7ID+aysua8i5LpqctT3Q6ICaCH0YWE3urbl9Ml53WNqg1yBRLt0/MlX3J3Nchcs3LSHwRQTbKz4K5G2l+cZOIvQdaM9d4DgGPTZxY0jR1B/I+DHXVWKIikJRvf9dQ9C83jVvRiQ2Sx+fQMOeNSMDnZyGL0EMpznhBddKCdzEs7RaTjXLrLV2WPRDVU8MHtF6JDnkosZkWw4FSTP5RdbK7FTaSzuA7+mu+R8KA04Q//m2C3PM+ZNAzcecvR8aKSg9iFkaQoSOBM8+ZWrHlKvSMH4fHTyHSgwsk8F14OaO3v+IqWmNT1tydlbGlymyxkeAcHKt3hU3J4JYn7Ve1a3SdKGg0uEb0msU9uhI6lE1FqUWn9p7s86eyXkGatoR/FQl7PgcHUT3CGfKLWg2rIOpug4fBlhiSRlF85IoDQ+i7v1c4+DWt//TIsT0KGlq4aN0+tY0sd+eInjY65uT6GIiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(41300700001)(54906003)(316002)(66946007)(8676002)(66476007)(66556008)(8936002)(4326008)(5660300002)(31686004)(7416002)(4744005)(6486002)(53546011)(110136005)(478600001)(2616005)(6666004)(26005)(6512007)(82960400001)(38100700002)(31696002)(86362001)(36756003)(6506007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1xZGt0aUFkTUJKQktMNUxCOUl1M3ZVS2h0UWZwRlFHeVpkVy9RWWhFNENN?=
 =?utf-8?B?Y2RRSXJseHdjMkZsNlhhdXVVODBoenJkcUs2cUtpK0piUVRjSjVnV05TRHVn?=
 =?utf-8?B?T0JSdlNaeUx1c1hCRGt4TEJqS1V5d3hDckFhaDdXbWN5cEIrSmVrRjZRWVBo?=
 =?utf-8?B?ZjdBSkxqa3ZWSmlVQTRxSTJLNU1YOHFHRFlQcjJJYkdjbkt4ZWZWQjZaZ3J5?=
 =?utf-8?B?bUFIMWRDVVV4NEExZGNmLzdmdnJpZFhuT0RqY1V1MGkyY3djOVpHVzNMY2l5?=
 =?utf-8?B?MDdpM3BVeC90cCs0S3VjekVpNTBpQmtRdUhkdTlkRFJSbzMxRkhxWkRiYito?=
 =?utf-8?B?bno5RW5CNkhtcWVwbzZkOGxaQ29uNnhKclEyOWlTR0NtQXVTNjV5b3BCaG8r?=
 =?utf-8?B?TkdiVTNCQ0lEeEFwVFg5ak1HTVExRmZGUEhzNm9CazNyaEI0WktZam54S2lz?=
 =?utf-8?B?ckRSRG05alNWTHdmTi92ZlpNaXVHNTdqaFdIUC9OUGxhTDFQcmJPQ0RNVHZD?=
 =?utf-8?B?MWZZTnllRkRtc2ZjcDFMdnBSZFJSUG8rVmczbHg4eVFGZHYrak05OGFtSHNQ?=
 =?utf-8?B?V3U4Z2ptTjV5N2hmeThLZ00wTjk3Wm55YWJSRGI5eFNNUU8yOVM4NWdRajRJ?=
 =?utf-8?B?akM1RjJXcGZISmd5NjAzUEF1Q0VFOHVRSmtvV1Z2SzUxbkh4dWRlS29HK0F6?=
 =?utf-8?B?OElRTy8wQXUxNEVQQi9VaU1aSVg5bTRxQVErTU0yamorZTQ4RnJaUkRnTUtS?=
 =?utf-8?B?YlFDVzVTaXpYK1dVLzlvcFZhVkpiTU5EcGJQanBabENEbWV3RHJFNlVMU0Y4?=
 =?utf-8?B?emxNT2kzTUs4NnRKQ0N3WllGTi9IalliYUhYemEySzNFaUVQWU9PYVhwNlda?=
 =?utf-8?B?ekswQTBJa1h6UUZLcDBxRDkrYkhSUHhUL1BxU1FQa2grRGNDb2VITWRZYlgw?=
 =?utf-8?B?WjQ2cUtVb3lETUgzN1U4S2V6b3BLWFg4ZFF1TmxkNXVIV1JpTDNCVnFSWUpC?=
 =?utf-8?B?MEdzRnNNME5GdXY1MzNMQTByNVpvdktBUTBrUmk0RDB0VlZoaCtUZThZRUs4?=
 =?utf-8?B?bVZyMHZOczg4V1doU2JxNHpOQnkyb24yZ0h4Y3QxYXRQd0tCK1RhS3pNTXlU?=
 =?utf-8?B?dUVYclMzbldHbzdvVzdFeWp1MHJjdDVSS0tEVmpOb0pFQ3hlQ3EwZnFNcThj?=
 =?utf-8?B?VlZIMnBjREs0ZXFwdkFYWEVleWE3bHlrUGJoendWOFZkQUlHWjFTam1Ya2VP?=
 =?utf-8?B?OWsxZVViRmhxNUJ1SjRha3dPOVdkNnRRQnR6SVZtbmlQVTlrUSsxREJ2ckhW?=
 =?utf-8?B?eHd2c2l6T2JxeGVENEhJUWYwb2cyaEdCQS8yWnBqeHcwU1lBRER4b3MwTnQ0?=
 =?utf-8?B?blBLRXdnbFBwYzRpY1hOQkFlSnY5ZktOL3hkWTZ4YWszYUhBcVAxS0xiSTFS?=
 =?utf-8?B?YitQZXg4N29kb3VxKzZNRFVqL003S0NuN1FaSGFrVEk3WHA1YmxkdGNydDNH?=
 =?utf-8?B?T1RwTVpFWXF5YjB4N3pLN3JTSEFBcWJja0xBZmdhSHVJeGU2dVQ5REUyZGc5?=
 =?utf-8?B?NUlXd0pXbk1KaDZxdmhObGg3SE9ydHMweFZKT0owUzlYWTBUc1J5SUFuUWJB?=
 =?utf-8?B?NEplcFN1YzVTa2RTc2dYTVJ2T0FCbFhsM3JzbUltWkNtZDhmTi9wU3lRZ1g5?=
 =?utf-8?B?UFh6T29jODZYZWFLOHd4aVhwc0J1MXFwV2hhUkYzLzhEV2o4VjFRU09EZDlp?=
 =?utf-8?B?bDk4UGxmdlFCcmNZQ2FvUXNjSmZLZHNCS3ZGOHZtOTV2Qy9PaGV4STM2VWVN?=
 =?utf-8?B?eDN5dndxZmpLR25hTlJqWmYrcGxxQS9oOGxla0NwREoyemhTczIwYWhydE5z?=
 =?utf-8?B?V1FaWXlPSVFOUm9objh6cGRZYXFxWDNUc05oTDVlc0lERVR3QVdLYnJ1cE5a?=
 =?utf-8?B?N3hEVkVySXhiQlJHcHlTaVYzMmlDSU8vS2U3VmpiSXNyTGZNYytDT2lMd0hO?=
 =?utf-8?B?UU81Y0x0TkVQd3RWUWpLNW5RQUNJaUdDRkxkTFJ1QmEzNkZqUVlDS0ZEYS9y?=
 =?utf-8?B?amxvM1A0Q3d6d21YeGVKa1R2ZW8vb3hPUXdoVVhJb016NzcvT2JNeUFoeTRw?=
 =?utf-8?B?LzB2ejNVenE4SW9FQjFoNzF5Y3JQMktwM1RrRVh0djRRb2FKN1Mwdkl5TUVY?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a7ed42-cb79-453f-9eda-08dbc110223a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:18:44.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dErCdMDmqX1wMxTfpKRSelVbp71V3zLR95w3JfZz1QqyYV7zrBoNQZmIXOV2GL9AWKEiUJpgW3ooYjEAhtBuhD2Ui5Ze9rkUFDYsvCPkU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 10:00 AM, Chris Leech wrote:
> Allocations in these drivers that will be mmaped through a uio device
> should be made in multiples of PAGE_SIZE to avoid exposing additional
> kernel memory unintentionally.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
