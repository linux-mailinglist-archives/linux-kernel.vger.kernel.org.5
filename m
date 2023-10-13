Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B97C8CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjJMR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:59:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07931BB;
        Fri, 13 Oct 2023 10:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOHIW2/KGF0VjBgcukYGHgUFoznketeeDPngvzdfHIl1pE9+33vl715qp5O6zauSsmHBSZuELf9Eg8knCL2OaOTl2aRMYHXVeegor+qhmFKaQcFnTPUDBriCc0h8CpsCEbe7Eq6XeGm//yb2MoZ6/oQiE9PVUOjBcJ4Xq3vFTEvxveUIBt6AebL30btQhjLNYaJVGes+Sqt7HHY8nnS3FVr3M/ssbmTiZ9/rZW8ZgqDaHMMA50IuoAV1gvBr1Ftd3KfEBHkST9q1kUdlAnbY4yV8/tua7rSuC79sX+49pZ6hyNESgre30sg/kNzeD/F6qiNFhyx+9rwS1ONi0K6mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyNHbWVsJOblhNzHHZBWyGZMxqb3kTkI+AFgLTDTs5Y=;
 b=eC69HrlvRZKCxhg9RrKumALcYTskCNJ1oBXezUS+HY/h5q6kq2lNV/DoA6CtwYtQuZTtRuekzTthrWRnpwe5TcOdsvXuWjd/O+aYAcvsS7OZWM7QJOmoIeMtM0jYxlJxdN88OPn16MFyDe1ItQ3DI7mtOtB3WgcG1J1TEjtU8M5ThbQg1SnQE1rCDmzYwzwf+DeeQ68MtVp8VHMoLbyhTixx6r02R2HBUFePQIW9WR+VbguSesQl2FZ+As/RerAu1vuK12e3cdA2/XT/xXt4KXT98fZdfDebs8FiaZr+xKq66JRT2egW9kIIM3umoTAnrNJfJKfxhHvQIwXA+2MTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyNHbWVsJOblhNzHHZBWyGZMxqb3kTkI+AFgLTDTs5Y=;
 b=kmq35+M2QwkZ5sPkVFRvhd1Y5So59hASufemlHLKkgsFB6MBx06G4RC2sCPiWcL+IFIVf4/7j5ZqKEJ2eZ6bEgjTEPAjtTMMoiZdavwvU4rZM9dXb65OZGStF0OGd23j+aMO9PMy/3+OJCddcZENkkHpAR15nLpbpGSfmnsF3sQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 17:58:56 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 17:58:55 +0000
Message-ID: <2e0dd79b-ab76-8632-5e61-d682e1311ceb@amd.com>
Date:   Fri, 13 Oct 2023 18:58:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master
 and MAINTAINERS entry
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thomas.delev@amd.com, michal.simek@amd.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
 <20231013-january-caliber-2e7acbee15ec@spud>
 <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
 <20231013171822.GA4177785-robh@kernel.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <20231013171822.GA4177785-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0236.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::7) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e118c9-6fb0-4e01-c0ec-08dbcc16116b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sl4lxmL999lENkqBscLP8yYLFYyvPPbYPQmDs/5F5Intc74WHCtic//FbO0zZMqnxmYY7j3bemiaIgZMT3wa5QtB5APc9esauVUx/fDL2Wn3eub7WYlO4oVAo9NX/mKzNsMnO9IX1y17gRVOMvAeg4Yr9KYx7eOnmaCJc7lXoRTnqdL0CVaGBVP+Heap1evwJYkCCI5BL+4k4rOxi2jEN+C360OtRUQFFhJLs1bIDE9C5kcLcppPLdMxBum+zPdgGvHa9gfxLQJHpYahsMv86/49MjDwmaVcp7ih78SBBZ6gieR0SFM93Sg9xbau/vHULkKb+ilZJ5r3fxIO8eqaOqB6OCXimiNGrzRzUEKps6yZIu9WYUO4T82dYYH3mMIN9Z4Fqb7dzW8wpacpCXbFzuFsZ7fjgs+4gHojbD5hZFNN+lUq0xyWe6e/CNhdg2Ilx0XycujYrLoQ54ElMm25xLuhXN6su8O2b9M74HLw4f7/IMFo04RZlvCsK9awzHgrHXluc0rdvPMLM7FVDC/K/ATZAoPrmdJs7vpARMUpMXaoNcI6MHzd9ftfy6zs9v2ZGVIdcNt1vyPUCyYiU9vB8RmXUFO4LEA4x70EzS80nZ98dNrjPR414OwAlJFO8Qb2SkbrR1xkXZoiMe7rlC3vyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4326008)(8936002)(8676002)(2906002)(6486002)(31686004)(5660300002)(44832011)(6666004)(478600001)(6506007)(86362001)(31696002)(53546011)(6512007)(41300700001)(36756003)(38100700002)(83380400001)(316002)(66476007)(66946007)(6916009)(26005)(54906003)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtBdWtYZnJxR1B2am5wbVN0Zi9rbExlS2xSTUFCcC9JK05Ld0NDMUFrd0wr?=
 =?utf-8?B?WGdMcXVGZDE3TVVQRHZlUnJnV2hBdnZ5TUZmbnR5U0QzdnJqQkdzZjRlbkZN?=
 =?utf-8?B?Y0U1T1ZjVGY1RTZSWldSTFMydDlKUkZUbFcxSFB1YmxlUzFJRnBjUDNKK2py?=
 =?utf-8?B?eWErWW5hUzBrcUtkTVBGUzc5SnlERFF4QmhoSGRnZG5vU0FYN1BMRHlkZzRQ?=
 =?utf-8?B?SVFzTW5leDd6eTJUVENJRWJNZDBRa0x3S05RQlFUNFd5cU50SlFEc2RzeFRJ?=
 =?utf-8?B?clVXQnQ2WFQzRlZ0QmJQNWhCNFVDcnk3QXlFemFmUEZydG1KN0dpdFhXMm5j?=
 =?utf-8?B?VmpaZ0pwNHBHcUlaR3o1WElXYWprKys3UnFqQUEzcHNFNDcrVjhGeHBFbTd1?=
 =?utf-8?B?b1kyYk1WUnNGbXBaeWliWjZ3aHN0RDhUNytDbERHYUZ2ekx5L29vRlJZNmJ0?=
 =?utf-8?B?VWs5Skhrd3pNNU1XaDEyQmw3VzBhK1E1RnNtUXY0ZkxiR0pQN3NGem5JT2dM?=
 =?utf-8?B?K1VYNXIxakZSbFhOa0xiMjZIQmlCME5Nd1JCVnNnS2VaS3lYR2VTaUg4OS9Q?=
 =?utf-8?B?c1VubU8rVVlTc2tWaWJsTmRHeGpCZDE1dHJHQ20wR0JQMklFam5WalRFcHc3?=
 =?utf-8?B?SHg1MDJERHlDaHo5T05rRDBIS2VjbVdJZlJYTzdtc2xkM2YxTC91MHFDWmNx?=
 =?utf-8?B?SDl6dDVuWjcvMDNKWDF2VHlVR2o0bEx6WTFLRlREQ29WNGJIWlZMckJ1cGl4?=
 =?utf-8?B?WlBpNUdrVjNnaWtiUEp6ZyswUXJZL09jWWdrbzNTR1lvK0ZmUUFVRml4VlFL?=
 =?utf-8?B?S1dWeTVsVkhxdWdlblkzZncxajR3RkN4dENtb0hGRUxwcTEzTVJHR1VXT3Fk?=
 =?utf-8?B?MjJsdnErQ3pHYzY4ZEIvcW56L2lDUXpwNWZMNUNaVG5raVpOY0dzNGRwS3JT?=
 =?utf-8?B?eWY4S3BYdmpxbzZsMWtIMDUzWFl5d0MzZFBPdFBoNWxPblFnTDNLeHJmZ1F2?=
 =?utf-8?B?ai9Pd0hXcXI1VHZ6SnZkVFlldFFiNzJSNXFVenBKWDA0MEhVRHVYTktpeTd2?=
 =?utf-8?B?eWg1MHNPQ2x4ejJ5dzVkSkwwczJaTFlYcGZxaStEVWkrbVoybTlNYVVGT2F1?=
 =?utf-8?B?ZktmNEtnZmxDZ3hEeTFHM1RxT0srKzRUQ1VuemJZNHNWM1pjZXZXV0tXWjhK?=
 =?utf-8?B?UUVmUzBDVWhBdWxaQjNNeFlxeGo5STlwZzFUeUhCb1FHTFJ5VHUrSmlnMERl?=
 =?utf-8?B?THBLNnN2MzQwVG5WeUZRNU5BU0pjZ2tQczRxRzYvWHNiRDNNQjdUK010YWJy?=
 =?utf-8?B?WFdXK0JucDV0M2NlelRyeE54TEFDcmVTM0ZXWkRQU2JIUXFqZFkvV0lFandT?=
 =?utf-8?B?WTVOWXVQVE1wM2NvdjFxc0grL1hETDgySExMYVZVZEpaZDc1VWhlazl4R28z?=
 =?utf-8?B?SzdXWitkN29KUU11bDRaRXB0ZW9RWDdMYVh0di9XbVhzKzNoNTFhY1lJTjBX?=
 =?utf-8?B?Q2RjWEI1TUFKTndzN094N1lBaThwZ2lKQWJOR1h5VW1oSE5EYzR3NGg3TnU0?=
 =?utf-8?B?eFlDOWw0VzQ2VFEyak9EdWZWRFRWRTZhMjFzdElNZHg5VWtCcjV6YjNxLzBW?=
 =?utf-8?B?UGd0UHBXaDdBa1BBTUJzeU9DcUtyaVB0OXpVdEN3aDErMnQ2WnAyTzhMOXpG?=
 =?utf-8?B?cm5iUlk4cnNFT1BDSmtsL250aGE4cVZPdjNzYXVJdUQzRUhiYVUrSTFBMkpM?=
 =?utf-8?B?eHVTbG1UbnFqYTRSMlRYUk45RXhPVlJ0cGtwSzRYSC83aDUxaXA3NUFCSnYr?=
 =?utf-8?B?M1d5eHFHZ3NiOWpuUzVjMXYyN1hoMlNPNWdyVFJDa0RVWFphRHBlZzJZK2E1?=
 =?utf-8?B?SXNrSlZWOU52L01rVTVPSHFhNjZCWlo5akg3dWlMd0JwZWpxQWNxbXMyajFy?=
 =?utf-8?B?aDRxOGtJajNaWFR4OUJTcTNvZ0NQbmtyS0RmY0dkMmxVdXdKbXJxYXRMVTBS?=
 =?utf-8?B?YjZJTnBOREFraXBHLzErcituY0JyaWxPandkcUFXVzJMSEpVc2N2MGhZTkVX?=
 =?utf-8?B?a2N1dG1EWldOc1VpMkdJQWNaTm1NYlMxSWdDMnV1L2xiRmNTSnVlelRpNHBT?=
 =?utf-8?Q?lcwvHaWZAcIUJuFSaimEaa4rH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e118c9-6fb0-4e01-c0ec-08dbcc16116b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:58:55.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqhvsZy0DkgcxvOWUfmde+QFCrC7QfemHwy+M5Ya2nqRlROg0x19ODdjdF+Wn4oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/10/2023 18:18, Rob Herring wrote:
> i_1wire_master. It is a soft HDL core.
> Only 1 version of it (ever)? Like other PL IP, it needs a version number
> (and not v1, v2, etc. made up by you). Really, your versioning scheme
> should be documented (like
> bindings/sifive/sifive-blocks-ip-versioning.txt), but Xilinx started
> versioning stuff some time back.

I've specified the PL IP to have both an ID and version number register 
in it, which is queried by the driver on probe.  As such we can version 
autodiscover.  Should there be incompatibilty in the driver due to new 
features in future PL IP, the major version number in the register will 
increment and the same driver can be extended to support the modified 
behaviour.  The default code in this first version will check to ensure 
major is at 1. I'm working with our IP group to encourage that all new 
IP have this mechanism moving forwards, as registers are a lot cheaper 
in logic than they used to be.

+  if (ver_major != 1) {
+     dev_err(dev, "AMD AXI W1 Master version %u.%u is not supported by 
this driver",
+        ver_major, ver_minor);
+     return -ENODEV;
+  }

> Also, 'master' is not considered great terminology nowadays. Perhaps the
> catalog name should be updated.

Agreed -  I've used the term to fit with others in the subsystem.  Would 
this be something that is changed and aligned across W1?  If so I'm 
happy to get the HDL IP renamed and binding / driver documentation to 
match if an alternative designator to replace master has already been 
chosen and standardised across 1Wire.

Regards
Kris

