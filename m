Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBD7DBCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJ3Pw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3PwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:52:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCEC5;
        Mon, 30 Oct 2023 08:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie/4+8R+dcdSlqN1nR08nQEItJ5MP70m36N+K0sxb/CvL6bi26AeoMFuyvEK79f+f232QmilM3y4u0JteEkvIYgUnS7t0qLfmtqzklBznJjsGiKp7qoTq2Im7loBgpfwfOzTzig0zCTXTQ2yuJ5IBIDkWDTs6qNYPYWlVIbP0vbZKA3Up6DNtOKyprifVckVIvBQ5fokzsy2jpKgNH5M3MTMUxPiE8ythBQe4DPixuqHEjz/nPXFSouZ3P6AHdewX7DG+ACP3Ogm7rBZUzdtWhHSM+VTZQXItQ9YBVzGr142sTYmv4vCYGt7+W+8WgG6wHte/Ppo9MlRgH+Qf9gSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY/u0RYlROT8r++xbmWk3XSor9PEcXGD87AG7kSyVAo=;
 b=bNZGJqC+swRs8SPC0AvPbPRBNdZOTHjyMLASlnf47gqkdBdAOCbkzUrlwla7Hc2EyKbzPQCGv0PAyNN2ZIpKT7sezdo3zZ2RD5iG8UDNG9wh8oRgUI4qIo59qG6ZHbg1JqNT9k1JMe+wWw0tF3BM5xHnqRqOHNidl7QlYFnKrF9jVtLzgQPfmqacb+RCzFOW+FEzx3THmtttO3kpl3zzZLlDEBrFnrNTu+x68cEkwt1zyGKWEFGfgqzpPN8TAdlMRqrtxrLXL05BAjKxVN45iEr9w9dx87crlFYiGG0p7vpVyLmhgvfixZMiakpUAsmCi968MohkvSPm/PIK0sVdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY/u0RYlROT8r++xbmWk3XSor9PEcXGD87AG7kSyVAo=;
 b=oGa3KyCL4w+l+xLB71F6wP3tjCG8oN2Ask5OgKY4QiDp7ettBG+ACKcbeHc1b7N8T53QZQ9e1G2XxnR/WKjIQUguhpaOgpIP5j8UZb9RfXP0bmxxBQoQ54VJepe7/CWM0TwN/QQF2ddmH90e0Jc6M6KAhFSWQvFSabQ+LD5/z2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Mon, 30 Oct
 2023 15:52:17 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 15:52:17 +0000
Message-ID: <83d88288-e82f-4c9c-b0ff-cc404e093a56@amd.com>
Date:   Mon, 30 Oct 2023 15:52:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI
 w1 host and MAINTAINERS entry
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231026093029.3122573-1-kris.chaplin@amd.com>
 <20231026093029.3122573-2-kris.chaplin@amd.com>
 <20231030154015.GA1141490-robh@kernel.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <20231030154015.GA1141490-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::7) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e1ef8f-dd4b-4e37-b639-08dbd9603170
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezkIns85HcXC7zD9LwANMAqfhMOsQIxR0o0JpnG1hr9/jSgGPvjCwbhcnNzVwQgOJ3nsdswE4YJ4/Thf/VJGtWLn/G4/YP+8ygVRDQRvnXvl6wopcmV1FhxsJ6fjN4b0T29qxkA+H7h2OvKD9Q5Asi2YB4HGwG1u/0LBNbOX8PSZX47Wg4M1s04mLCWvfIDLk9Mn9V/PBLJ3oiyDK5eX344+DlIXxvB9sHBb0Islep3N8L9W5DaOI/l9pxM+KNGhL7anghy2oe8GZ+YndYCY2WoxouVwv21E1ycWLcvGd5ewJkSuxJPAIB4fMAekJhSnBh8/RxeGOECVmWQYQwXEZ18rSXQ/anO/q3m89mx223IapMrGKi8SIpKcnT6RfgXPr1EA+5IRun5Fntes9JvJ9NBp/+PWe2V0RsM7AQbpzZkbb9pfvIqShE01JBSyV6bQ9MgDRwvtkg8vR0ZHTxKL8Ay9hTTG6CKjM/rwJI/HnJC95ImS4vaQ7XgPHrl09luzA0YGDGpIEH3gi6rkHsQUFhSEFqj0zvczjPsN/iblfQBw5xbK7LCD56K1DbtdN68k5eSBwOgDTjopku0OpoMsDHFsh77dDoPypFzAuWyw2mlxVbpwltKTC+JdzW7es+RzvU3J3QxjQDCjmE9pafcolQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(86362001)(36756003)(31696002)(2906002)(6486002)(6512007)(478600001)(41300700001)(4744005)(8936002)(8676002)(4326008)(6666004)(6506007)(44832011)(53546011)(83380400001)(26005)(2616005)(66556008)(5660300002)(6916009)(316002)(66946007)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JkZUljNk14eVhTTGhCSHNlUTFEakVIU2NlbVhDdms0dmxVK00yMyszS1Zw?=
 =?utf-8?B?MlpPV2pFd00rR0tNUURiQVBGbldZK2NSby8rVFo2VUlndU1rS0k1WDVCQlI3?=
 =?utf-8?B?VlR1cTYrK0p6eU1iVXhSRjFtVnkwK1dDTnZoNWt1R0RCSnRSdmNrYmpUSVkw?=
 =?utf-8?B?dkRKNFE1ZDBERW1BWHlQQlEzcmdocmJ3UEQ2WGQ0NjQ2aXFoLzBXQmF1dWRr?=
 =?utf-8?B?OHI3SE9OTng4aXFaZ1dJUUt6MkVKNzZ4OXJRVTk2M2NBRkZLSUh0Y0t1MWF3?=
 =?utf-8?B?NzU1TEtSNjZDZ3VrUEY1K1JQd2o1dGNxZ0FYbExqWjNYTWkwRG43dEFyNENs?=
 =?utf-8?B?RXE3b2x4Y3FHaHQzSmhvN2JNZ3BWWVhUaDlBZ2dIbmFTbWxWRktFMVFtYjdF?=
 =?utf-8?B?azFNM3c0Q04xYm85UTRZUDVZbFh5b1lDUVgvempNcGpraXl6WG1RcFEwd0xN?=
 =?utf-8?B?SkZzSGNocEFFR0pEYjdoMDc2ejdiTnpwSWxmbFdFVnhub2tKNTFGdlg4Rmhm?=
 =?utf-8?B?RTZjUW53ODhLQ3JqbmZ0b2YwZUw5a2VRYjJ4UGJXNnVQSXZYOUxTeVdCUnN5?=
 =?utf-8?B?L2VaTkYvcStKdVhWa3hzUVdCNjY0YkxkN0puMEsrSGlhYjVRR1BVUjR6Zzg0?=
 =?utf-8?B?bHFLcXp4elhHQXBDRm1oMnFjbXlWOWFyS2F2c2RVdGpuZERyaVZuSWwxRU9N?=
 =?utf-8?B?WnZrdE9ZbmlVRVd3eC9zRTNraGhtTWN3T3h1ZWJ1UEV0STVOZXlmeTdzMWhB?=
 =?utf-8?B?NnoxMzVzRDhRTnFhV2RkbFJCeGFKdnJZSzkyaTE5YWZWbDhHbll1OUdOeThQ?=
 =?utf-8?B?TTVvWDdZaHRnL1pjVUd2THA2ZUoweEF1MlVEeWZDTEtEb2RWMENVZjY2SlBi?=
 =?utf-8?B?M0dUY1JvRjN4QzlQMTZhNDM5N2o2ZFVjYXEvcG1NcHdwd25kR1dUeU1DdGdF?=
 =?utf-8?B?Um5ZbzNWcXJXODhmWmpRbjVxUzFXZ3VubGNtZGx6UjlEUnFQRUpua2RFTzU5?=
 =?utf-8?B?d0k4cXMwSXVlVTBRWmZ6RHg4UnQxcW9KczhzSUkrVHA3N1BpTVd4WEZiOGdD?=
 =?utf-8?B?K1NyeTVkaGtZZHo1VFpmRmMrTGRZTVdoZ1RqMk1oeDR4bHJST0RrSHplVGI2?=
 =?utf-8?B?NlFyVkVTU2JyL0M2T3A3dFZIQWV5Rzh0VWhVYk52bXNOZkxacVRwRk9jVk5M?=
 =?utf-8?B?ZWxjeHdxbktuaGZ0dlR6dXBVdE81SDlRTjY0U1ordE0vTEhDSm81TEpuckZU?=
 =?utf-8?B?aG5LaUtLS3BSOFhHdTFsdU16WlRGcUl6V3RwaHJiUWhITWFXcGIzTzZneTk0?=
 =?utf-8?B?S0hnOGdId0lDUjU4MEd3RWVIVEhibUZweUNHYjVEREg0czVPcm5BTi9sSjYy?=
 =?utf-8?B?VWRFdGtNeGtIQ09TUTJtTEE5clZBYk4rOEN3WjVrZlVWSTVUNmtmdk9VK2Mr?=
 =?utf-8?B?MlU5WVcrYTZNbVRYUEh4ZjV4TnFHdjdLR203SmxramlIT210WTB3VWJIdFpa?=
 =?utf-8?B?TDZwMWpXVXcvYTNPMlVlVWsrYlhNa0pzN0swN0wrNUhER3RvUFFXREwyTmpO?=
 =?utf-8?B?dzNzTW1lUDUrOEJTREFYUEZXNkEyeC9hUTR2a3d1aHVlWWVSVytZZGRKMTlL?=
 =?utf-8?B?OVJlazA4b05rTlI0WGh2bjAzVU9XOGZJVmw0TGRnQlV6S0dCN2tKSTQyano2?=
 =?utf-8?B?ZlhjcFJoL1NmZmxXQ1JUblcwcmNzTGpRNW9Lb1puUXFyOVlLZityR25kNUtn?=
 =?utf-8?B?Vmx6RllWSmxxM2JIMy9rSyswMmhIeXNVdFZPdmh6bVlLN0ZWR2NsczNIeVNa?=
 =?utf-8?B?dDk3M3U0Q3VGekdrMmxWeGxPa2JRNzc2UGhlMWRBS1IzL2JjMnc3ck9UTXh5?=
 =?utf-8?B?dnhnbFhBQUY1VlZhcjVmNE03RnJyVkFQU3NTZEQwRnppckZUWS9xUE5CYXlI?=
 =?utf-8?B?Q2w0T1pxR2tOaVFOTDlKVlNQcU1vMmR3NW91bHZlRGpOZE9KRDN1QkJ1THFF?=
 =?utf-8?B?cDkvUGJoMVhhQ1BnMExIWTdpSkNJdmZMRnN6VTNnb2ZxUXQvUVBvM0xNK0ZL?=
 =?utf-8?B?dEx6RFBhVFp5Qm9zOFF4Vk9NalN4MTdJR1QzRVNMWXJIWGtkNjhBNk1SbVBw?=
 =?utf-8?Q?oGriJqf1A9gdlUiTQ8WXPstGa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e1ef8f-dd4b-4e37-b639-08dbd9603170
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:52:17.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1DSdUoUmYsrED0VZhpwfIRRm3N2yZWrximIXjLtM2Nww7LWWx4/Dv5PpDbHNUmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 30/10/2023 15:40, Rob Herring wrote:
> Is there a device side implementation? I can't really imagine that
> 1-wire would ever be implemented as firmware on the device side given
> its limited nature. So adding 'host' doesn't make this any more
> specific.
>
There are slave drivers as well as master, although these do not have a 
device tree binding.

The IP device from AMD is called "axi_1wire_host", and so we are hoping 
to stick with this binding if appropriate as it relates to the IP name.

Regards,
Kris

