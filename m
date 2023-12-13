Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30007811901
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377548AbjLMQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjLMQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:18:16 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC691;
        Wed, 13 Dec 2023 08:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkE3o1HRGKsdkjZAuNzGxGGWcUVqMnzN1hgtRVBzxit2tJ5U6x4hQqZrNm5sUiK/8GNW8pdZNbVpAkgBDm018Bp0JT9Hr3w2u5oMKZ2cpXirs7w/2aQQF6C+70wDArW+ik08WC2+9UPEcV4tlhZvt8lZFT4yDpF/2D7dFqiFtPZZ0V4yvt4SgikON56xJeE99bgpwliMkd6MQkhOCnNyX4xvaxJmNEqCzcbEcbDkGkpfnjZ7dnnpjCXTsIMhSbLxDA/yb+X8//Kagt+/XwKBG4Yaa/AerH9gCc9wOt5m+ir2HYLXueojhwDZfn/q2X7bfmjJYLxEAMFbt4//xQ9/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsjIVQ3LVq5XUK7iKWTo8ujPH56ZACiXE2oC+8uZnCE=;
 b=SSrMMuw0RZbZE06gp4M98v/0G5IPwQa/MkgMfcLDtoEU/VyzQGCYqyeOLsuhi8SqV1GssDjOVoivncGIoxNYk+kcOURDyASs2OM4jHgAgsWfPZPK5PhPzmo2uHPa4yzZQPuX6Fv8cisl94dChZe9YQjDe/i3Mm8yTB62ZWqnHb4pAFwOLxlalczkk1ALgkxUmFUuz+iECstvOBqD1hqc1Kfvz5bKYD23QsXCi9J5Onpocl+dBCIjd0lS3TE0mvNfy1blJhks3cNgBe0rqRCtW0db1Afw5ddUBzhGdfWAaikfmH90x2du60Fpu7gncKEMVFQXDFMgvQ4r6Jq7n8ngWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsjIVQ3LVq5XUK7iKWTo8ujPH56ZACiXE2oC+8uZnCE=;
 b=SzcdFwLdATt+mrXebTDN62RSVWifuMpDYEZCoGI6osCp49405utKOrWlO8KnPfY8wD3vE7L5V3XGgCy+COw9imJTPF3nbdkc/+U3J+n4gUkYgTGLZEd6jnDJRKmVmtRlcEH76lBodsC9kNKYGG1xjK19/3DOt8j7BPwZht+WR6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 16:18:19 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:18:18 +0000
Message-ID: <44052047-06c9-4b95-b040-2d4c7c1343d1@amd.com>
Date:   Wed, 13 Dec 2023 10:18:14 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] dt-bindings: mailbox: add Versal IPI bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Levinsky, Ben" <ben.levinsky@amd.com>
References: <20231212230353.888714-1-tanmay.shah@amd.com>
 <d91a9278-f70e-4f0f-92c1-ce0bdac69ff5@linaro.org>
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d91a9278-f70e-4f0f-92c1-ce0bdac69ff5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 388b9815-cc9c-462d-05f0-08dbfbf71de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLppi+BLvFedfSBnIRNEDNzU7ubjBmVmp/4LHuGTfDmpVopwBETTDv3C7ZHw8BhGLOKvcG0sIXRH7Rt7v+yZJd2Oa68TfM9hQyK3k+vt7rHtyW6pR3Ua42y2gZHZ4JNRTRL69efmA+XnR2GQklxieQUBLzkH57fCPQOeJVEGXpeU0A1Zi5NLqKDbpuAxuzKWLmC/X0xhrHSGSVFQEk7gPkGbOhKWDMJEhsmFEYdXAgn7Ex7qNGZMXTLHJftoYhM2O1Jrk1nfBX6vOx8JjctROEuOTpXRohy9tvIhik56C5LyQ1PXLBn16o2ochPKTP84Zm6O85YbtCIMJxIiBDA5C2MDUy+zCwR0l16v0sFtEbJf4FPRomzXQsElFmQOhh3hMQ2VDgJ74M9dNQbwOyP656/OE/Klp4VwpGwWf3jdYtSxC+4fbQ4Kp6SJLM5Se1xMqJQFgrSqpPgH9wVFxGA1RSXxWnNj9k1IVHQVFsFp1Jl4NRHsMXqSrCtutv8YridPRSUOmAGEf5uzOOvClRqfR6/tBelSlzeqw+IQpanQQvGjAgoEuNWZsJ9GUWhIBWm+i6OoUw/+rqAJdXRUSGEBiEZSsh7qsI7wKFp8SmvfjQDUEAH+0haeoLd2rAeLF0bvm2YXjL0tcFeBTXHDXSgbvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(53546011)(6512007)(6506007)(2906002)(6666004)(44832011)(6636002)(66476007)(66556008)(66946007)(8676002)(36756003)(31696002)(38100700002)(15650500001)(4326008)(8936002)(5660300002)(316002)(31686004)(478600001)(6486002)(2616005)(41300700001)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmsrOWl5ZzFVdktabVNUNFh0NStlL3hlRXlwZTF0MGFmbmxxYlgycmU5OUdQ?=
 =?utf-8?B?dlo4V2lHSXdodmdjWnh5TGFIVVFiaFFGMFBvTlM5cW5kTDQyUFFVREs5ci9j?=
 =?utf-8?B?MDBCaFErbmxRaWRXU2Zlb0hiY2pLalRQbHFRandib3ZHM0dZQVhpNnJzd2Vj?=
 =?utf-8?B?eHJKdnpqMDJJaWNSekl1dHRCdEgzdTNtZGRNOXBXVnFXV21VTk1vWGhpUHhS?=
 =?utf-8?B?bC8wTmpoT1F4TVdCK0wrWFVCRVVRMEsvWXFHdUoySzlwWXJLTlhTZWU4WCs1?=
 =?utf-8?B?L09BNnh3WVNYNDN3ZXh0S2djQVlFUVNmZDlWdTdJejE4aE9ob0lNN0dLbCtP?=
 =?utf-8?B?WHdsNVNScUlUbkVpNUJVVS9pSUk2TVRsL1YvaWtoZmNQTmJoUDNheU1oS3lx?=
 =?utf-8?B?OEZNYWFxc3UrTVVMQXdnVXBIc3RpN2ZGZUFOZnQ2Qjk2aGpaWG8zL2tVbTlP?=
 =?utf-8?B?TzhOaTFMbExzM0FuOXVZck1EQWFzUFFvMzFGTWRFUXhUMXVqSHpaUGlTYWk0?=
 =?utf-8?B?RC9qcVdxci9MT0k5eVhUeXZycU0zalkxS2daYlY1RmZEdElvNnk3eFhQT2Ew?=
 =?utf-8?B?U1lpbFpQNWRzRDltQ0I1M3NxenRyQmp5Rks0YkQ3dWN0MmNrMnpBbEZ2YmU3?=
 =?utf-8?B?VTBPTFJ5Z3ZKMFZmaEVZZ2dqWm0ybE1zSG1lNVZCaDVGOFpRdjZsRTBybklu?=
 =?utf-8?B?elJWNjhuMXZGbzNwd250UmZPcjAwWG1rNXo3VnNJdWg2VlFyVGNSRCtzNUZY?=
 =?utf-8?B?VDFFdGNveVF6eHVKYkhWS2NSYTZFU3hrbllXL0ZFQVJGNUJSSkttaUt5c1dz?=
 =?utf-8?B?V2VtM3FHT3JlcURUK0ZXS0lBWExXQWErUFYyZGZCYzd3dG1ud21hTW5ONkkr?=
 =?utf-8?B?S2YwVldIVTZCeElQdHJGTlRiWHNkWCt3aVBHRjkvb2NDQ2ROL1dnT0pJcTFt?=
 =?utf-8?B?M2t5TEpNWnV2M0d4YTZQNFdZS2Z1LzhyZjh6UXpsTG45N1dGMXpvLytwcGZ5?=
 =?utf-8?B?czY0dE56TWRtRXJlTkhIZWJyRE9NSnZnVGVJeTMxVlBNcGdmeXV1Uy9XM2tN?=
 =?utf-8?B?T1dNWDk3R09ZM2J0OTVGZVZXTHhEc2lQZlhZa2lNRmVvZEhrN1RGd1JjTXg5?=
 =?utf-8?B?Z1RGazNabTlVdG1KTWI5SVN5WS9VS3RGTlVOcFd6M0ZvTUViT1c3RXB4UnhC?=
 =?utf-8?B?MndsaFVkeUZyUDBCdjE3RjNGK2dxcjluZzFibnV0TVNzMDQ0QXBOZG0rdE1P?=
 =?utf-8?B?WFJBanJVWXRFWUltNjR4NmlQVkhBVEhGQmJlK3F0MWVwY0xxbDJhK2h6UVpp?=
 =?utf-8?B?QVFMaEdIYlVET1NncmZlYWN6eSt4V005Q1VkTHAyYU1SNFN0YWYvK2xmd1Nl?=
 =?utf-8?B?T2ZVd1lUTjhUMlNvSTJOTUplVCtGT0hiUzBsTStsNXp6TCtTc1JoSVF3UllL?=
 =?utf-8?B?ekRJN2MwaU9YY1RrcXdXRUdxRXllamxmMTY5bkROUmIyRnNJT2hmWUh0VFdz?=
 =?utf-8?B?Y3QvaVVoRW1uc1dkRXpIRjRwM2p1c0RMSWFTVi9sTXd0UnFScWl5aWRIMitR?=
 =?utf-8?B?OFZBUTJZUUY1VUZ0Mm9oSFBRN1hITjZGSkZ2OFhiREMvbEd6SFNSK3FueGdX?=
 =?utf-8?B?a3BtdjYyZlNmVlhPWC9pUnBldlhxMXdNWXMzSWhnN3gwS1RmekRmRktqVHhJ?=
 =?utf-8?B?WXFSRW5nREZBVjBiWjh0QnpzQVFldW5HT3VpLzFrRXNFZW9BY0Q4ZTQxaUg3?=
 =?utf-8?B?M2NRNTJ5UCtnSzQ0cFd4QUdCL3FCSlR6ZWpHWmtPeXU0RTAxTVByUUIrbmM4?=
 =?utf-8?B?STkrMG4wMGJ1OGN5dWVFandVRTQzbkRMVWpMbHRGcTl3TDVxbDhEWFhmTHIz?=
 =?utf-8?B?SFFtcUp4N21jbkJhb2l4VUpMU29GNGQvcVM2Wi9tZEZGajIrTUZoenViZXpW?=
 =?utf-8?B?UzZsU1l3OFJRbWtIeCtxakVOUTRZVkpuTllzdXFhNVJWdjF3L2xWNEJncjNF?=
 =?utf-8?B?cHBxbEtlSjNtVUpRTUUrbXdrdWtDZ0hwdkFQd1NDRm1yWmpwb29XQmZmbzZ2?=
 =?utf-8?B?ZzVEQjdyOUhmVWo0VjBNaGFPZ2xZWDhxa3ZoODRwM2dEVXVQY1dsUlJwZUpN?=
 =?utf-8?Q?t29J5Fbh5Ku+oZ0h2MYZ/vOTi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388b9815-cc9c-462d-05f0-08dbfbf71de9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:18:18.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JCysiGLax7wyeK7LkBmCTEL/ezlmH98Dp3l5gKWhfgINrS4HgOtJWP3K4Fmmus3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for reviews. Please find my comments below inline.


On 12/13/23 12:35 AM, Krzysztof Kozlowski wrote:
> On 13/12/2023 00:03, Tanmay Shah wrote:
> > Add documentation for AMD-Xilinx Versal platform Inter Processor Interrupt
> > controller. Versal IPI controller contains buffer-less IPI which do not
> > have buffers for message passing. For such IPI channels message buffers
> > are not expected and only notification to/from remote agent is expected.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
>
>
> >  properties:
> >    compatible:
> > -    const: xlnx,zynqmp-ipi-mailbox
> > +    enum:
> > +      - xlnx,zynqmp-ipi-mailbox
> > +      - xlnx,versal-ipi-mailbox
> >  
> >    method:
> >      description: |
> >        The method of calling the PM-API firmware layer.
> > -      Permitted values are.
> > -      - "smc" : SMC #0, following the SMCCC
> > -      - "hvc" : HVC #0, following the SMCCC
> > -
>
> Independent change. Please do not mix logical changes in one patch.
>
> >      $ref: /schemas/types.yaml#/definitions/string
> >      enum:
> >        - smc
> > @@ -58,16 +56,26 @@ properties:
> >    '#size-cells':
> >      const: 2
> >  
> > -  xlnx,ipi-id:
> > -    description: |
> > -      Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > -    $ref: /schemas/types.yaml#/definitions/uint32
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    maxItems: 2
>
> I don't understand why this change is here. Previously you did not have
> MMIO address space? If yes, then where do you restrict the old device to
> disallow these?


Hardware description is different between ZynqMP and Versal. And so, we have to design

new bindings for Versal. reg and reg-names for parent node, is only available for new devices.

The new device is checked with compatible string after "required" section.

Should I add "unevaluatedProperties: false" after "additionalProperties: false" for parent node below [1] ?


>
> >  
> >    interrupts:
> >      maxItems: 1
> >  
> >    ranges: true
> >  
> > +  xlnx,ipi-id:
> > +    description: |
> > +      Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 64
> > +
> >  patternProperties:
> >    '^mailbox@[0-9a-f]+$':
> >      description: Internal ipi mailbox node
> > @@ -76,57 +84,116 @@ patternProperties:
> >      properties:
> >  
> >        compatible:
> > -        const: xlnx,zynqmp-ipi-dest-mailbox
> > +        enum:
> > +          - xlnx,zynqmp-ipi-dest-mailbox
> > +          - xlnx,versal-ipi-dest-mailbox
> >  
> > -      xlnx,ipi-id:
> > -        description:
> > -          Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > -        $ref: /schemas/types.yaml#/definitions/uint32
> > +      reg:
> > +        minItems: 1
> > +        maxItems: 4
> > +
> > +      reg-names:
> > +        minItems: 1
> > +        maxItems: 4
>
> Same concern.

This one, reg and reg-names are available for both old and new devices but, with different

definition. And this is checked based on compatible of child node below [2].


>
> >  
> >        '#mbox-cells':
> >          const: 1
> >          description:
> >            It contains tx(0) or rx(1) channel IPI id number.
> >  
> > -      reg:
> > -        maxItems: 4
> > -
> > -      reg-names:
> > -        items:
> > -          - const: local_request_region
> > -          - const: local_response_region
> > -          - const: remote_request_region
> > -          - const: remote_response_region
> > +      xlnx,ipi-id:
> > +        description:
> > +          Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 64
> >  
> >      required:
> >        - compatible
> >        - reg
> >        - reg-names
> >        - "#mbox-cells"
> > -
> > -additionalProperties: false
> > -
> > +      - xlnx,ipi-id
> > +
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                enum:
> > +                  - xlnx,zynqmp-ipi-dest-mailbox

[2] Here based on compatible string, "reg" and "reg-names" are defined.


> > +        then:
> > +          properties:
> > +            reg:
> > +              items:
> > +                - description: Host agent request message buffer
> > +                - description: Host agent response message buffer
> > +                - description: Remote agent request message buffer
> > +                - description: Remote agent response message buffer
> > +
> > +            reg-names:
> > +              items:
> > +                - const: local_request_region
> > +                - const: local_response_region
> > +                - const: remote_request_region
> > +                - const: remote_response_region
> > +        else:
> > +          properties:
> > +            reg:
> > +              minItems: 1
> > +              items:
> > +                - description: Remote IPI agent control register
> > +                - description: Remote IPI agent optional message buffer
>
> Were these described in old binding? If not, it's a separate change.

Okay, so I will split this in two patches:

1) Clean up current bindings (like remove redundant descriptino, sort "required" property order etc..)

2) Add versal platforms bindings doc. (This will add if else cases and Versal platform support)


> > +
> > +            reg-names:
> > +              minItems: 1
> > +              items:
> > +                - const: ctrl
> > +                - const: msg
>
> Blank line
>
> >  required:
> >    - compatible
> > -  - interrupts
> >    - '#address-cells'
> >    - '#size-cells'
> > +  - interrupts
>
> Separate change with its own rationale. Trivial cleanups can be
> organized in one patch, but should not be mixed with adding new devices.

Ack


> >    - xlnx,ipi-id
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - xlnx,versal-ipi-mailbox
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Host IPI agent control registers
> > +            - description: Host IPI agent optional message buffers
> > +
> > +        reg-names:
> > +          items:
> > +            - const: ctrl
> > +            - const: msg
> > +
> > +      required:
> > +        - reg
> > +        - reg-names
> > +
> > +additionalProperties: false

[1] Here, if I add unevaluatedProperties: false then is it enough for old device to disallow

"reg" and "reg-names" for parent node ?

If not, could you please suggest how to achieve this?

Or is there a way to undefine "reg" and "reg-names" based on compatible property ?

Based on your feedback, I will post v3.


> > +
> > +
>
> Just one blank line.

Ack.


>
> >  examples:
> >    - |
> >      #include<dt-bindings/interrupt-controller/arm-gic.h>
> >  
> > -    amba {
> > -      #address-cells = <0x2>;
> > -      #size-cells = <0x2>;
> > +    bus {
> >        zynqmp-mailbox {
> >          compatible = "xlnx,zynqmp-ipi-mailbox";
> >          interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> >          xlnx,ipi-id = <0>;
> >          #address-cells = <2>;
> >          #size-cells = <2>;
> > -        ranges;
>
> How is this related to Versal?

Yeah its not, will go in cleanup patch.

>
> >  
> >          mailbox: mailbox@ff9905c0 {
> >            compatible = "xlnx,zynqmp-ipi-dest-mailbox";
> > @@ -144,4 +211,41 @@ examples:
> >        };
> >      };
> >  
> > +  - |
> > +    #include<dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    bus {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +      zynqmp-mailbox@ff300000 {
>
> mailbox@

Ack.

>
> > +        compatible = "xlnx,versal-ipi-mailbox";
> > +        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        reg = <0x0 0xff300000 0x0 0x1000>,
> > +              <0x0 0xff990000 0x0 0x1ff>;
> > +        reg-names = "ctrl", "msg";
> > +        xlnx,ipi-id = <0>;
> > +        ranges;
> > +
>
>
> Best regards,
> Krzysztof
>
