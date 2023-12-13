Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4B8117F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442309AbjLMPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442635AbjLMPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:45:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24379C;
        Wed, 13 Dec 2023 07:45:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDoCc7WdL2SEkavcroxRfz5Fusl2hyETgJKxm/3hVQ8xJTAa+JGEAqIqJQgo9dgDwk/bsAWaA0/PUo71kRFkRH2QJAf5ddjNotrxh0FDbPugXdrQtdTBalUWiwcanPDFtHsurZ2NgA6Z5pMizCksKqkxds4Ftz2Z2K0Flbqw9yxvtq0WFkUUi+MAaKdQQbVro2vaFHYRBdXdiue/eJYlbySEDb9x7Hn81fztEvXS1PJ3jTipfGf7zWtFHPqP+zQ85qFez2KAq6Eebx/40CePxv3sXM+K2+cJJcX7WzveR2ZkdLhcShtMtqs8iXeMbg8keNGOt+FRm/VX2IXvW2cBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SZGFjgH9K9E9Yvc+kO19cX7ubEPEdToaYpFgCA+Mf8=;
 b=dmZEcDeaX8Bzxj7xgx5dt97eJeE3DjUIVGIu/q/6SZesIUrktbOejBRxcZOc/djqfLgK7+Z2a3qoAg9i2AxTbK8FzbYixntxL11s19d01ySc22o+AiOxCTLGDlWXYo1ZgF0NXk6f/RGTpoKyXpgZ3+dyrotoqAw0VA8WC9wghlHiRTDaCpmxdxiynQY0wKIRkd9PS8zBfcw9gDyHDyN3wqwBNujwEgNsAhtpQq/uC+MX94Dv9hCROjViPb7oNDq2vzSJL91crTo99ynKGj1H2q3EcdsXTimQJ8epE9AkcBK2LtIWE7WgdLVXbexyt5jjRB2Lod2/pfpw/m3cNYdK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SZGFjgH9K9E9Yvc+kO19cX7ubEPEdToaYpFgCA+Mf8=;
 b=w8sXLMqmJSkyKJ48Hgr1MzYs6uVBM9StKrU5Wv9gdyPG2x4Ave2RluIw0huvRH9O2jqY3789+6tdam/b/2XKHsU+BIO0Iqjeiv6ss3L++Xl81hPBK0YlFUsuKsefBE8fOS350TNQvuBOshocUc/72IPOI9YlMwHkdw7Dk9/QLog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:45:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:45:32 +0000
Message-ID: <0164c37a-872f-43d0-9b3f-f351a7fda31c@amd.com>
Date:   Wed, 13 Dec 2023 16:45:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     conor@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, robh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
 <69670e5a46c98a2eb73d4f2e2d571a27c46b4640.1700722941.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <69670e5a46c98a2eb73d4f2e2d571a27c46b4640.1700722941.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cb8c0d-c410-43b7-4320-08dbfbf28a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RG/Q5T2jvUujpMXjb8kHF6TliRvKn7HctRUIMsG1VVXDleyhBMi8/c8SrdD/5sobUBmbybXanoAlLR8yKKz6i+vF6KtWyHRPhH3B6zu4vpujserohEnXPyfos5W6M/zp8ctizBoDawS3i4BXYdPTldSxhPNEx6nobNTo/US9v/G9iyKItFS/VSsUX7RVBnyjPjKF2AhpzjJ+1AcIzQzmpk5Gil88MOV8NGpDSUcJx5pd+bN3LXIoR/Hlo8IAEtu8dDGJu+TcDsRhtLW1TUCOulh/mqgEFcnVBObPQubyEWuo2rP7K7kgEmrK9S1BNVICpe6+IGvXNBqzsTcQaTxnLJJo8ZVVnSDz2z3srTNcucexFT0e8pRR5W8UwBC247ViGWG412MqX+jIJZ5jEC4Afim6y1pIxsIdEtMi+sR5lITOKt9xsvp5A/I5/S40DK8fMA+0gytQeN8sc86wlGc9Nx7xTVi9BBwkELJus2dR9FSq6BT7hem7owCFGVLVFHvRjz9mJGzqNXCBvOzm4g01mUQwWca78rf7UBnsIa0RN9fniXBqiaJkCWyJK99HuTvo1dYs4pO5YhurJNrIMDHppIIguFepT2ncTxYKFZJqv/Sc/dtX/w28QxnGEVDfQcK0iNDoq7HWTsi/vUoX+IREFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66946007)(36756003)(31696002)(86362001)(66476007)(38100700002)(6512007)(53546011)(2616005)(44832011)(6506007)(6486002)(6666004)(2906002)(7416002)(54906003)(316002)(478600001)(5660300002)(26005)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlxVi90TGZhNm1ycVVyS25obnYvd0JNaDJLaFlFNW5GQWlmRWdOSXEvK09C?=
 =?utf-8?B?Zzg1K3ZZajIvUXZPV1lBeHYvclpNLzVhVmFWamkzNWRZSlBSb2FrWVVxR1pu?=
 =?utf-8?B?UXNhY3dpazdJSUxuT2N4eVZ4SDdXNU8vY21WaUtPWDZyQWgzcjFPa3Nzbnk1?=
 =?utf-8?B?VXlaNWtCcVVrN1VDZlRDL3huNFlabFdNVlJRbDVqTS9SbnZHb2VYaEtEakVz?=
 =?utf-8?B?ZzB1NGlsWWFpZHdyUklFNlhZc2VpSzZwbG00STJydXBWTzZrQWc3Z3lXOW16?=
 =?utf-8?B?Z0d3UXl6WTZrK08rbHJFUGJQY3hoczVKZ0JidHQ0cU9LK29aTlhrQ2JuSmxP?=
 =?utf-8?B?MUFnc0lBQzNzcVMzVm1xdGtsdXczbFdqa0k0c3NBTUNGRXVGTzFZYnc2V1Zn?=
 =?utf-8?B?SHdLRC92Mjl2V3pubm5IaDNpQmtHL3F6SUlxenRxN3JXRnRlY0FBOXp6eU9L?=
 =?utf-8?B?OVNZQU4vUlBhYzBkRUc2alZxNk0wQUIySUcwT2RDS3dhTUVMdGxMMXZGcFQ4?=
 =?utf-8?B?amh1OXB6YjJCVzhJeXFveXFJTUk0emhJK0hRQStIQUovU1YrZWQ4d0VERDZH?=
 =?utf-8?B?RjQrVlNhcHdGelBGZ3FMNFhsY0ZMdURPQ0VFUXR1UnpDOFY0RW12am1zTFU2?=
 =?utf-8?B?dGUzZUJicnlnUUVhSVczWkdNTklsdFprYVQxUDhQajAvU2JBVThYc0E5cXNs?=
 =?utf-8?B?YmhodkRJK1h0aVUwd0JrTXJnNW01ODZtWEsxT24vdEFkWXB5OWs1S0ZHa2JY?=
 =?utf-8?B?WjZhN1lNeU05Z3ZNWVV1ZEM3OHBuVFF1WGtHVjFnTFQ3aDJFOXM1YjdsVjRK?=
 =?utf-8?B?UHlLVVBjZ0lVMHpzeHNFNHY3bks0OUk2QXRXYjdGbkt1ZkJBaFY5VEJxRHFl?=
 =?utf-8?B?NCtMd0szaW5YcHNHRnJIeHh4TktsZzhGbThqc0hFcmIzNzgrTmgzWStkZms2?=
 =?utf-8?B?Zk9CUnExZ0h6ejliY3BxeDlPRHVsVXBIdTEvVUpRTjUyTHVtc1pZd0trUHFS?=
 =?utf-8?B?VTEzQVhkbEpIK3JxcitnM1BtVE9EU08zdDBlZmRiWFpPRkRYeGgwSlBkYkRt?=
 =?utf-8?B?cnFZTFRlUDJ5WnNkYnV4b3lpMGxITkszM3cwcHZnZmoycjhvNE1YaklrM0lt?=
 =?utf-8?B?Tm9mYzlkUjBtNWxYcHNEckUwajg4enJtUGptWW1tellTaFBSQUdtMzJDN1hW?=
 =?utf-8?B?cW1OWkdnOXdOV2VWS0ZIVkxVR0hzdTF4bDdQVlFtd01DZVNtbXhYZS9aM2JI?=
 =?utf-8?B?UW5zTDZqY0JxUklHUm5ML3hTc2ExYVdPc3kyZG9nMlRvQjZKKytXTjJHeG54?=
 =?utf-8?B?Q2FRRU5WRlBERnhleWMvUlk3TS95QUpNMVR4a1AwTmkwemY0UU1zdDFhRm1u?=
 =?utf-8?B?Z2ZLMy9MMjEzdU5IeEptc0JicU02Zm1xTkdxdDJ2aUxZdDdWeEJYZWtySzB5?=
 =?utf-8?B?Vmw0cUprUFVxUyt4SjFCUnhOVXJXd05tRFgzQW94aURlZUU0SU92NjZBSFRO?=
 =?utf-8?B?cG1WMHlrcDY3YzJ3WGVHRXYwZWwwdG9WYUE2cEdUSC9TS01xcHQ4U0MvWWhH?=
 =?utf-8?B?djlzVk9uTUVoTElDQW5hWVVXUnUyV1hCTzN2dHFqVW1oU242b05KTkYxdExZ?=
 =?utf-8?B?bFFhUjFsZ2pZSS84b0RUL29XYWNWUmh4YStLbWZLUkFLSHB4N3I1Q0hjdU1h?=
 =?utf-8?B?WmFSbCsyazFpL3pVWHYrU3N5YmpkbVJYVVN5SHVKTnFmdVBFRWk3bmYxRjJm?=
 =?utf-8?B?amFuaVVSeFBVQzZVSzNnN0dDMFJJUzk4ZnVYYTJzT2kxUHlJQkppYnJHRGhY?=
 =?utf-8?B?YUxYeHB2Z3ZpNE94NkhOb0szMHlEUzRoblp4aUJZS1h4WTJ2bndGd1B3VHFj?=
 =?utf-8?B?dDdtYXpMa1V4MmM1UzRmbDZ6a0F2azl4enVndHRCdkNqK2N4TmhBTGREOFNs?=
 =?utf-8?B?M0JIVmk2Y1dVaWFIdkJBZ3p1cVp0UXZrTWUwUkZYazNlYTNIeDZSS3pKSXdX?=
 =?utf-8?B?ckE4dGF4amYxRFdQTjB0bmF4MTJUcGFuTnAzdVhHUkRoWDZkYWwwb1Jlc1Mr?=
 =?utf-8?B?amJVSUNFQm5QNTg5TVVaeTFWQjB6dUtQUnpuME85ZXJHRVcvSVBManAvSzhB?=
 =?utf-8?Q?AKItDjpIhRz6E6hYrquE7+xEB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cb8c0d-c410-43b7-4320-08dbfbf28a2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:45:32.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/LYvbuHlF3LtRd7G3uQxUUZrlRYI1cAOo1MJ51wwQREStOw6KXFIVTAJaGHVRYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 08:02, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor. Processor can
> be used with standard AMD/Xilinx IPs including interrupt controller and
> timer.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v4:
> - Fix indentation reported by bot
> 
> Changes in v3:
> - Add Krzysztof's ACK
> 
> Changes in v2:
> - Put MicroBlaze V description to xilinx.yaml
> - Add qemu target platform as platform used for testing.
> 
>   Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> index 95758deca325..d4c0fe1fe435 100644
> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> @@ -132,6 +132,11 @@ properties:
>             - const: xlnx,zynqmp-smk-k26
>             - const: xlnx,zynqmp
>   
> +      - description: AMD MicroBlaze V (QEMU)
> +        items:
> +          - const: qemu,mbv
> +          - const: amd,mbv
> +
>   additionalProperties: true
>   
>   ...

Applied.
M
