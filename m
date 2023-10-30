Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1CB7DB5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjJ3JGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjJ3JGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE439D;
        Mon, 30 Oct 2023 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698656767; x=1730192767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6dWzMhgvOrEmlz7CUlno9gY981xIbAouDTpt4KreMA=;
  b=SQIZHHrVbO19f4hn91mq5mgD4Kv4JgEdoP7gKvGn/3+4nwq1yo+oweiB
   pQprmsaXpRZA9Lp/pgjCwgqVMqJoHIB+gpQ/8poyMst9i65XPtOQtu8jx
   ESsDM5fk+i5aQJe4FHP8CKYN6k6o6ijuGmginwiQoQCRpXrnzTPA4nf1D
   GU++1CmOFMzMs1iFBp06NxhApMaxZLSnbWZoGES4DwIfoFLcwqBauTQyT
   MLK5zAwZmHdmqmdZnePfyQ+T5nXB0GWJbxcfM8PaeDlx9HuUfSZE57DiS
   MYuLme3X56FP1MwYFsi2RkjJ1+7cMjZBosCvR6BdHLlTV/W4Wjv0S8fqi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6672179"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6672179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="736682689"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="736682689"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 02:06:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 02:06:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 02:06:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 02:06:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 02:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbmFS9QYJde+kqC1aPKNOp+G2mtxpI32X60CPSVK8YSpJ/FG0dxKZF1ELujgjzNKOMERIG0ZfM24WEudThyxfeDOJ1b2IFQkaB8Qb90+ZUj8KkjQvmjDa1rxvPFM8NCd2F7Vt4oJQ//95vwF9B6cfFo/VahRR2z8tK+N27iq86y66wqRF8BpqX8JZL5qw1B4fkA7WDe8GrIWNFUrQTeoWiXODDs8WooRupgciJV2PV+kFaaOnTJwHgCcSOY6hZwyUuViJ9XH/Q28dy8DlXWk/FeGPZnn7rI2aAUoPxn5VA4i+oSPZy3ilIit8e4WwS675BM3Gyu/KgkVyYVWUyicfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaLlvCkXo7ewHIlnfRWRo4F/MIcKsk+4l6sgxBYI+Yk=;
 b=WOmySiHw/HA7MWUPVa2bbiEz0dLO4D7haMZDurL7hUkOOeN93mme3VRbN/cuYR0sJw7NbCkj7wZeu6F+88587bbxePUUyZ3xQDG6QrT5lavXu8Hqu9rGFnuO/KYV+9FGYur+jdTaOspSPoJhpZzPXvYaW01Jkf+67TBEvMI46Eyrht9hBkRvCh/JxEtRKf0h7b33l1S9ULtuNwjNXMW4qSW5tm5a7Jd/kbfYeI1TrvgPRpehh1mSvpqos0z7Z3LqlYRrobnl9IB7kHcTAapVC9vaBhu4Ue09L/P5nR7qDisd8B55Eu9t8RfDjV2mLR+4pHq6Tfsq3lJouUOb944fGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 09:05:59 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::8f49:2d38:af01:b29c]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::8f49:2d38:af01:b29c%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 09:05:59 +0000
Message-ID: <e29d0306-329b-b5b8-aa50-4e3ab0ded1e2@intel.com>
Date:   Mon, 30 Oct 2023 10:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and their
 sign-off
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sean Christopherson <seanjc@google.com>
CC:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <workflows@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
 <ZTZ9Bk3-NrK_cVDu@google.com>
 <887636af-6be7-f418-bfa4-d85501f2f40c@intel.com>
 <0693460e-2104-49af-b1dc-5ffae0f279c5@kernel.org>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <0693460e-2104-49af-b1dc-5ffae0f279c5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fccf393-e945-4151-9548-08dbd9276dfd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xXceGKElCb5zcWTaBpysU9qqsvjlkWlbFwKO4f0/he0o0a2s3jFhSDHC715pGzyshwUO0oY08rFB3xS2l7vuRi4Mj6D+w3lCK1QKvShPo9yeWeYV4tBshipwSdykfEaHjwvORUcs3baO8CDbHFcb0Ia5gMEM8xKvoPlAmGGHCr1Q+UzliK41CE9FFj2OiYk10l1o/tVY8Bb33DfVSaY1Y0akv0dH8pShlfW1ACNee03owvt+k2SDI0SKe2cUwxYlDsebEgQpKdl3S/6MTV3KIrR8LUO2siDBm0Zlz4xo9qHEmpjwVm8jzuzBek0emaY8O7g95Ibfi6qvCGrskHmAF2fDvwtjnX+r2bjdLnJHNyUUuszfhEWNn6OquqCB90mZrGMpRU2rodsFhMSz78yFMF/hsH+bFVDLVnAzFjf0xAJKTVqnf4rEBiV/Ys8hwQjGxcb3zyV/d4JTuRV3z12VsjBL5KLQFSK9yaJILWpgUzjKJ6W7+Yk6mNr8lHr79uAEICnbTKX2fKRK26Ng2RGrsW7BdtyPpOcJT81QVw1iE6QBUK3kbwsoXaho5f4CP+yP+O3TtNtx0AUzEoTyaCYrP79cvBgBo79pzy6/GkYcRdNouO5jTLRskrrxOl5QQuXfMshQmVWEKKl+Dm7M2gHJ2EPiWfAypRGfU3xn2+zNPuciqxLocbrq9RE2d9kT1AR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(5660300002)(7416002)(2906002)(478600001)(4326008)(6486002)(8676002)(316002)(8936002)(66946007)(54906003)(66556008)(66476007)(110136005)(83380400001)(31696002)(36756003)(31686004)(86362001)(38100700002)(82960400001)(107886003)(6666004)(6512007)(6506007)(26005)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FMb0NpdlNBaDRQNDFjWEtSZ1E2K1VYWGpZZnM0ZUdCbDV3ZnlMbVRFRXhH?=
 =?utf-8?B?YUVFZUlycC9qS3czc3d5RzFuVXA4N3lXYlJJWWVaUEdDMWRQWlFrbzd0a3Nh?=
 =?utf-8?B?aldRWnY5NnJ6YUFUMk1LQVVIbURQT1BQbVRVU1dsL015cVpVdHpOZVh4c0NS?=
 =?utf-8?B?MzJCV0wrVHhWM1lBYlcwSjljMmIyTXZOa0pSVXE5djZQYnlkMkxTRWg2ZU5I?=
 =?utf-8?B?SGdxbjM4OFRkTFVSQ0FzdFVGME5mTEFvNWRtelJKcGxTMnVRNnFQKzZuYmJR?=
 =?utf-8?B?WTJKb1oxYnR5NE96bHdwd0lPSEh0TGdyUUFLZDMxZkJWSVJuTVF3ZnBjd2Rl?=
 =?utf-8?B?Yks3WjQvT0lNdUpzaVNxb1UvTmpWZHVLbXMvbG16ZVM0cTNvZ0YrYUtsOE9o?=
 =?utf-8?B?Q2xCQzhzWmd2NlFicVFoY3greC9PeGt0Nlp5Vk1oNk9XejJjVVM2Q0JtRWpZ?=
 =?utf-8?B?c0o4eHY5Y2UzRUJvaEcrUTNEek1uME5wOXpWMjI4REQ4NU5tRHZTSTZPTmFZ?=
 =?utf-8?B?NytOcksyblliM09QcGdRZ2I5cmNadU9BYzNFQkZQeXlmRUNWTjlDWkFyempV?=
 =?utf-8?B?cGplVHlhZmxvVC9sV292Z3JTbVJtODJxd1FOSTFmdnpHMVNQTnM4SUFLUHZQ?=
 =?utf-8?B?ckVYOW5OblZldHNiMFhVUXFpMkJHa0RySjVTU3lsem1UTG4xY1FFcDBZdlBl?=
 =?utf-8?B?eUxiRytzMEYvN2s0aFF6dTR0Uk9XVGkvZjJUZmk4RW1STWJoTWJxVVhROCtV?=
 =?utf-8?B?UFB1Z1UwS1hoMnNsL2FXUktBZkk5VktPMmdlamtQNm5ScTdGNnU4bXh5eEVq?=
 =?utf-8?B?dGxUUjczejV2dEhrM2xhOC8xWGs0bjdDWjNMaGV5QlNMZHd6bmovVEo3ajAx?=
 =?utf-8?B?UC9TVmlnMWY2VVd5a3pyb0ZGU1RQelhzZkQ5czU3VVR3alRSdk1rWXBFRjZP?=
 =?utf-8?B?ZlBwT3EralFMa250a0c4dG0zb2FqMkNsSStXQk9FVTI5a1ZrMkg1TS85SXd3?=
 =?utf-8?B?SjNJS05CdjFtZHVuVXE2WXExSXBIK3RmVHcvdzF6bTIwczkrdFlOdXRJSmhB?=
 =?utf-8?B?WTBaT1RHZ2ZPMUNMTnRsVTFJbnRvL0pGa08zMmdTRU5rcHNmdG1OOTQxWVlP?=
 =?utf-8?B?em1GYU8zQ0xkUlpkK3ZUSXdXQjVHUHJSVlhhbkZkV1VyandpZGxhQzdWMGc0?=
 =?utf-8?B?QXZtY3AzV2ZqYkxkY1g2Ui9MVkZSeXlJanVOd09WSmlUTy84VXE2NDJoOXM0?=
 =?utf-8?B?OXU0R2YvVXBWZTNQOHhJMGt4bm40QURyTm44VmlwZm01V3B4QVQ2MnZ1RmtD?=
 =?utf-8?B?bFJaZFFNLzU3THh5cjhQRGU2c0pxY2psOWJ4UHd4ZCtGS3VkbHRUNU11dFZh?=
 =?utf-8?B?ZHRGMzhMMnI3SDJ1SUtkbVlOa2lJc2d1VlJuS0gxbHd4MlFiMmdaS2wwSWpV?=
 =?utf-8?B?RzB0MHhZMm1pYlpNMTB2dlUzR3pLbHFxMWtNMEF2WVpSem1SZTdZTXhRdGVw?=
 =?utf-8?B?SHZVNENtWG84a0FESDFkZ2Vscm5PVzhEQ3djaHJNNHVLNUpVMzNTL1Jnd2Rv?=
 =?utf-8?B?UFZnTVBSOEZiMW0ya2swZGRJR0ducFl1dmNLVEE3cnFpTDdpUEpreklJeVdE?=
 =?utf-8?B?RjgzWmZoMklYZXhLNjJwTC9ZaDlPYmpGdklWTTJmMER6OWljS2dydzVhdUxF?=
 =?utf-8?B?RjdWTkh3NHJvQzFTM3J6MmlzcmJLZzdMZ1hnNE1ETGNFTnZLQ01BU1FKOWlX?=
 =?utf-8?B?YU5sazFpeTQ5RklrTWg4ejlpbENQOXJGOUU0NzQ3MTFUaXp0K1pUS2JubkRY?=
 =?utf-8?B?VWQ4S2ZMU1ZpRW5LN2FYZjhST05PU3BTb1A3VWRYei9LZk5DakdZYUFSKzlO?=
 =?utf-8?B?Mit1MllmV3FUWEVIaE9POGNDSVFhREpEYmliS0xjMnBvUFovVTNyUmxvTmtM?=
 =?utf-8?B?cmlqeWsvem0zSXhRWjMxVGh4amtOeDB5TDE2MFBPankzZFFaQTBrcFRhc1ly?=
 =?utf-8?B?eitqdk5DYWViejFSY0t4eGlId2c4ajk4NzV4dnNWOTg0MG91Njd4czU3UFl3?=
 =?utf-8?B?VmM0TDRJVWprdUE4dXFIeUlvZ1NPbXNFZGtWR3JBQVp3azByNkhoWUF6MkdK?=
 =?utf-8?B?MmhnTGgyK0lSazZCNFNvL3MyaTFWc3Bvc3c3aUZIT21TZDZSMU9OeWlLZE5N?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fccf393-e945-4151-9548-08dbd9276dfd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:05:59.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppbeqBbmz0rME15Uxx7SlhTWa0WdiCdiedzX3/P2bmufHCA0uST+aVNQM9aNttcpTOQwLLx6DT8h7Zi9Mh7fvB46PbpmH6CaRkn/Y2lRMn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 10:35, Krzysztof Kozlowski wrote:
> On 24/10/2023 11:15, Przemek Kitszel wrote:
>> On 10/23/23 16:02, Sean Christopherson wrote:
>>> +Mateusz
>>>
>>> On Mon, Oct 23, 2023, Przemek Kitszel wrote:
>>>> Additional tags between Co-developed-by and corresponding Signed-off-by
>>>> could include Reviewed-by tags collected by Submitter, which is also
>>>> a Co-developer, but should sign-off at the very end of tags provided by
>>>> the Submitter.
>>>
>>> ...
>>>
>>>> Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.
>>>
>>> Heh, there's a tag for that...
>>>
>>>     Reported-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>
>>> And it's usually a good idea to Cc the reporter in case there are questions they
>>> can help answer.
>>
>> Heh ;) then I would get a checkpatch warning for not providing Link: to
>> the report, somehow I wanted to avoid those for checkpatch contrib :)
> 
> You wanted Suggested-by. There is no bug here, so Reported-by is not
> suitable.
> 
> Best regards,
> Krzysztof
> 

I would really like to see Inspired-by: and use it a lot, for cases that
some talk ignites an idea, but it's Suggested-by
