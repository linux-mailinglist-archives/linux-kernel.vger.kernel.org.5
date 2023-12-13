Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAB8119A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjLMQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjLMQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:35:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF39D98;
        Wed, 13 Dec 2023 08:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqe9KVdf3+2Xy5OrV3vEYJTpwNBKudnr3autPYgNZDsssLU90dUbrHZvzQtWND0A7Bzz9IiZWFzqIRiTkPFlPOyoueneFFPSnA6UWOQtCJvfy0XTt2TmSEcoKpTtuMBcB73C+ClTtdZJwG530QpgZQ6L8ir283txY1wMYWptU4kn2JPlqwiIDQ5gLLf0ZGxt8HR14azquk0iqip7wstKS1+ewvTh3bJbPyPvIM7mNkydwjQ8hFU3RsEoCTNEmavSPu/t2ut2o1c5feDa+gipPrS1xc9eEFiY3i1qvW6T92ThxkZW1y8D5k3zyGgD8rnrLPgnAS7rLUGwO8NuZ/4vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDXVf35fz6pJ39slAUTBlWAn8mcjv55BnzXX7/C/8sw=;
 b=GGuctBvoWi7yk201HiQhtDq7dy1NirnrsMaYFuUSSzFGfC6tBkRgOtGhYBW9Vqd/Qfy6aEEt7ngw4l1vVbJgxgnpjtR6KpMAg2uEB9so0AIxTOPBZLlPEMKdJ3uQiB9FXPwvoY8wjOXKiLNe5x+80/4cvS3nkakuHfm6f3qObL8CiwfV4k4qF473ng1gplwDT0wR2DkL96sa4LpOmNSM1ucW6CEEaigu/+gU/ZIWmFy0AwDzPz+FGUeXtMmsR3IrX0dHLhvU9VZaEAxzsm3Nr47pGpIYjk9iCzDeQPLO2b3k0UIBE2iFlDzQ2Lw8PXQLnbVSxWWf22LZ0/Gxiu56Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDXVf35fz6pJ39slAUTBlWAn8mcjv55BnzXX7/C/8sw=;
 b=zt0q//UFnNyBoqPAmkawb2G/pFIrc0QqeWGEchwVLaYHrwtID1wdTDROulW9C860g/U5vCO9n2Y1Fse+CtifftVDzjI6mKDAldNCXMCyHN5W1vuVhWFtSByA25cs0JbhkYpmc6D1NCsOVXRFIiZiNQCWdKc+ff+O13ChuY3KJGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:36:01 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:36:00 +0000
Message-ID: <1027ec80-bed6-4b51-b346-60bc19aa04e6@amd.com>
Date:   Wed, 13 Dec 2023 10:35:57 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] dt-bindings: mailbox: add Versal IPI bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Levinsky, Ben" <ben.levinsky@amd.com>
References: <20231212230353.888714-1-tanmay.shah@amd.com>
 <d91a9278-f70e-4f0f-92c1-ce0bdac69ff5@linaro.org>
 <44052047-06c9-4b95-b040-2d4c7c1343d1@amd.com>
 <daa14201-2027-4732-bbea-acbb2675e4b8@linaro.org>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <daa14201-2027-4732-bbea-acbb2675e4b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0128.namprd07.prod.outlook.com
 (2603:10b6:5:330::20) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3cccd6-3e01-41ac-632d-08dbfbf99739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVwfaQYBys4JqHO+3RxF1DDgs/H6AXm9gYItF2uKTkRBQjRl4K+wpJ+O6kLfCf5zMcsCoHykW9ZdJ41eRLuPBoDDoWabblI/JMxmsxsMkZ4kD9itVZBxWf/mj1/3vStvTHgLr0fOJrw5h6S7+i94ytJtd4ByjLgvPwc3WXXyYDnDS6C1G2TDSzEnMBhgZIuyFcrg0slFtty5xox9n7rqj0tfGH+pi5BzZXSfefB6EFEi3g9LaC7CqWNiSx85Two+UyDD6Mo3xxcqwwm+lmSf+8FtEoHWfSyJY9fab6Q+WCt3VV84Jy9aw7aHFnmzUIVO0hvjx2A/JW0MaELxj+VVqeyXEeT7KXvSQuGG/L77u7Cevv5c3TcVEVI8ZWRzhJKs2JRSYFeQqopU5NfCOQrT0NzpobycRvEpcAnwRAyUmH9CrqgEW6Co/ldLuZEe1CvQlHuN/D9oDjSuws6IirJD0FXAtDGSnxeAy7URE+ahAOK1/t7ffMTiQRBVQmvpMffnFxrlKaJBFPBuWxUPxuhrKsKfueruxLqPcqehAb9vG3zSdf/VEkezvXAmDN7UCJepMqyHEdV25tlYdiIgiPf9YolRbtV8guhtwjrKZJqS3+INCJnmW8jY/b3DKT4u4+r47lHvKTyyuyqqernGtkroPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(26005)(6506007)(6512007)(6666004)(53546011)(83380400001)(15650500001)(5660300002)(4326008)(44832011)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(6636002)(66946007)(66556008)(66476007)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhnVmdQMUFkdlFWNEFFaFMrb05NbVZsQ0NDaXdMMlBtek9RS25xemVLQ1dw?=
 =?utf-8?B?SkM5L0lyRHp1TzI4eWhjY2l4Qm56TndRc3dHQ0EreCtBZjVraFlGSGQ2dlFU?=
 =?utf-8?B?TEFPOUs2V1NYQ2Z3c0ZndElRTHhGdGM5WVJsSWZOVS9Jd08vK1JiVGtsa2to?=
 =?utf-8?B?NnNtQXl3N09Qa3YrTEM0VGUzU2VObUFTYlRYRkRuVnl2NUdaZFhYYk1qNDA0?=
 =?utf-8?B?UnRyNU5KS0dzZ3BpSHAyZUtvb0xMd1FvWVp6WGMwRE5WZVFBc0RqRXU1bUhF?=
 =?utf-8?B?T042Qld4aEZFK1JTTEh4N0VQblRUOTh2VzMrZTdGck5od0hhUUthRU9MZmsz?=
 =?utf-8?B?TW1zUFJSbTZxQzBacTJ0STZsQ2pvV28xZzRIQytlMTU2cnQxNzRvK0J3UE1n?=
 =?utf-8?B?TDAwVUlKV0xkRXRoNXhsT1g5RTZJNWN0YXNCbmRYbWpaRDl0SUdGWm9QUmNa?=
 =?utf-8?B?M28wa1dORENHK21GMmpmZzNBRENrcDlnZDA2OGxUMnpiNzJ0RlduUi84U2x4?=
 =?utf-8?B?V28wVGN3UHdIZDhIK2NCYkorb0R0V1dHa29hM1pRVFY0WlNiaUR0YU0zVlNY?=
 =?utf-8?B?Kzg5c1ltdWVYR2tsaEZZRWdIeWlUcmUrTzY1VTZKWHQzVFZXSFl6V1dwMlpT?=
 =?utf-8?B?YVNEK3YwakZuMjdBMXJhU2N4aWtnaHJxOVBWYmRSWGEvUHNYZHRvT3Rzdmd2?=
 =?utf-8?B?WEd2V3NSVGdHRnp1ZmsyeDdYNklPSnRGNkllMUZHeGE4encvSWxYeHZrM2Mr?=
 =?utf-8?B?WEt5bVI4RzNucjYyWmhzb1ZLa1pxYmNTU2ZrMXBremRDbWp4VFpjbUZucEJn?=
 =?utf-8?B?b2FWN0srOG1GVHkyanc1dDVKbGY0eU1FWmd6enMwWC85djBqVnhjdThoOVpO?=
 =?utf-8?B?RCtDSk96Q3dkVEcvV3ZiNncxQ0E2Sm1taE5kdnBldHVVWHVzc0Z0Tk5jSVQ5?=
 =?utf-8?B?K0FhM3p2WlhPSDZVR3JxVWVSRjEwZ0hmZmdQLzZ3anMvc3FER2Ntd0R1SXla?=
 =?utf-8?B?akVKUFI3QVU4Q1Iwb0pVckU3TzVaNzYya2MvWVNES3BKVGpGaS9zZzYvcW10?=
 =?utf-8?B?YzlTWmlsUGF2eXpqLysrdWdhcFpJQ3EvNDA0WUtjVWtQdGkzSkREN1lSU1hW?=
 =?utf-8?B?aURBSHlxZTRLbUZ1UkRiSUM3TU9CYzlQSDZud0dNWXdYR3ljendSQzl1ZktK?=
 =?utf-8?B?OGM3QkxrR2JoTVNqK2I2QWtyNTlaRW5sNnV5UzIzMVRxTUlQTXJ4dzdWWnlR?=
 =?utf-8?B?K0IrN1JzWjVrRnFNdUlMNG9sdGV4TytsVmhNQWFSaU1IRXBPL0VXYWhxdEtN?=
 =?utf-8?B?WU5nU2xZTTBoT0R3VXpoSDEvOXZpemkrY21LaXJsU3dWZ1NVaXk5UkJ1WEdv?=
 =?utf-8?B?Zy8zVnFsK2FBWFJoc2U5ZjBJY1BNUkJwRmp5YzdsYTVFclNjNllGdnFzZ0lN?=
 =?utf-8?B?Y3N1aE15VmQ4MFN0aC9XUzdaVElENHlaVk1kZml1d3NCSXlhZDltZHA0MkRz?=
 =?utf-8?B?N1FZaG1xSzhTbkJWTzlOYnVJOWNpd1Y5THNtRlExRHUvL2d2bTV1dzJMbWNp?=
 =?utf-8?B?ZDdmUFlyVUtjSTFidjJHekNuQWhucHEwWmdpU0hZUkQzWHdsNXA0WU55RTB3?=
 =?utf-8?B?eEpyNXBNbUxhZ2R2N04xb1dxMS93STl6WnhxSm1RM3ZKQVpKN1oxeW02UHl2?=
 =?utf-8?B?SUIyanpGeWV1aWsvYVJ6UElhTUtMREtlOWgyempsUkFoV2Fxb05GdUlFR3dS?=
 =?utf-8?B?SzNJcW1aUllPYkJQSGYvNGpKTjJmdnQvL1NBNDZsUVQ4bWRSRkNBNW50NFZI?=
 =?utf-8?B?cGxqUHJVUnpmYUhHREFiQ1lnZjRWdFRJVDNqOHc2N0NsS2dDS0tWQU44Z1ha?=
 =?utf-8?B?UFVyM1RxV1FyY1h3cWZnSURmUE9yaStsLzZnVlBJbmNHeHJtb2pCTWtPa1Zr?=
 =?utf-8?B?Y3NidjBQUjZQaXVWVUpCYWlsUGlKcUFhRzV2U0o5Y0Nja2Y1RmVGVHpLRXl5?=
 =?utf-8?B?VFNTeEJiWmRWWmVodlZyZ1lmTERidWt5NU43NHhRS0pwZlhVeERYMnB1bkR6?=
 =?utf-8?B?dzZGbjZucFJxWGU4b3VZbW84S1pza0VrYUZzVjR6ZThOaTBnRGVib200QjUw?=
 =?utf-8?Q?kwosMQtbNC/7v6XgsXDV6VFBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3cccd6-3e01-41ac-632d-08dbfbf99739
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:36:00.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCSC/2K27+fY74p/OCuvBy8JseOD675zYiuXIM5hXQqDpcpHAmq+a32IOvpSD1Af
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/23 10:21 AM, Krzysztof Kozlowski wrote:
> On 13/12/2023 17:18, Tanmay Shah wrote:
>
>
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>
> >> I don't understand why this change is here. Previously you did not have
> >> MMIO address space? If yes, then where do you restrict the old device to
> >> disallow these?
> > 
> > 
> > Hardware description is different between ZynqMP and Versal. And so, we have to design
> > 
> > new bindings for Versal. reg and reg-names for parent node, is only available for new devices.
> > 
> > The new device is checked with compatible string after "required" section.
>
> Hm? What does that mean?


Following [1]. I think You answered what needs to be done. I will have reg: false for old devices.

Thanks.


>
> > 
> > Should I add "unevaluatedProperties: false" after "additionalProperties: false" for parent node below [1] ?
>
> No, you should disallow reg/reg-names for older device.
>
> ...
>
> > 
> >>> +        then:
> >>> +          properties:
> >>> +            reg:
> >>> +              items:
> >>> +                - description: Host agent request message buffer
> >>> +                - description: Host agent response message buffer
> >>> +                - description: Remote agent request message buffer
> >>> +                - description: Remote agent response message buffer
> >>> +
> >>> +            reg-names:
> >>> +              items:
> >>> +                - const: local_request_region
> >>> +                - const: local_response_region
> >>> +                - const: remote_request_region
> >>> +                - const: remote_response_region
> >>> +        else:
> >>> +          properties:
> >>> +            reg:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - description: Remote IPI agent control register
> >>> +                - description: Remote IPI agent optional message buffer
> >>
> >> Were these described in old binding? If not, it's a separate change.
> > 
> > Okay, so I will split this in two patches:
> > 
> > 1) Clean up current bindings (like remove redundant descriptino, sort "required" property order etc..)
>
> If you want to combine cleanup and functional changes, then this would
> be two patches.
>
> > 
> > 2) Add versal platforms bindings doc. (This will add if else cases and Versal platform support)

In that case, can I just post single patch that adds new device support ?

Won't touch anything that is not needed for new device support.


>
> > 
> > 
> >>> +
> >>> +            reg-names:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - const: ctrl
> >>> +                - const: msg
> >>
> >> Blank line
> >>
> >>>  required:
> >>>    - compatible
> >>> -  - interrupts
> >>>    - '#address-cells'
> >>>    - '#size-cells'
> >>> +  - interrupts
> >>
> >> Separate change with its own rationale. Trivial cleanups can be
> >> organized in one patch, but should not be mixed with adding new devices.
> > 
> > Ack
> > 
> > 
> >>>    - xlnx,ipi-id
> >>>  
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - xlnx,versal-ipi-mailbox
> >>> +    then:
> >>> +      properties:
> >>> +        reg:
> >>> +          items:
> >>> +            - description: Host IPI agent control registers
> >>> +            - description: Host IPI agent optional message buffers
> >>> +
> >>> +        reg-names:
> >>> +          items:
> >>> +            - const: ctrl
> >>> +            - const: msg
> >>> +
> >>> +      required:
> >>> +        - reg
> >>> +        - reg-names
> >>> +
> >>> +additionalProperties: false
> > 
> > [1] Here, if I add unevaluatedProperties: false then is it enough for old device to disallow
>
> No, you need reg:false
>
> Best regards,
> Krzysztof
>
