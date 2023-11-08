Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC27E5318
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjKHKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:11:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D51BB;
        Wed,  8 Nov 2023 02:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZdmg5VLFzlCMfOt2o3GUaewOONE/LVKZO5CSO++gyTo20Qfb3w+hkyFY/OHOIVZKT4QkSU1QS4X9crjWwxhYxRUnVJFnMzZ5JkyBZdz9VcbcZyJDp+eIj0Tbn1fCu3BcmQXHV9j7PVll7cbSwR2595YkWk9I4RGjr5XKzHLR2zauFBY1Kc2xQ9XrNVjLzHp9UfAw/Ti64rz1ZqDOjt0QnBSN/lonodIEWVmi7ZODW5ZsMQGBqaLKI9a2TXMrw5eoC4hWLZKyCxm0sS6MtPwrkUtVSc/J9BEReHIjfTzoDD1XRaJoS8iwfM9+vovlvltO5GpoSPCPwqHfu09dd8SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH5YmcxfrQNowQFSopjjUOiewEjJbND/qb9R5mqqu7w=;
 b=GlxyH0UKoFRk36h+f8r2BYQaqw0IpqjsHYrlmyw9D3ajL3Kvc71QyQX6c2Pqq182yGjQ5Jjmjmz9ODxKk5N2TB0tji+xnDlwjOtjHamzHClsBZdnMzOrhhhkfHRZCs4lZrI6oC17uvQ6wCjHpM6VZ2477GY7KUF44HkKuFmNCbP1K3UZuubadw26TPKt4s0O1FKsS5xjaLtLWOwxK0g1IYCdE1PzJuiOiOnOmqoFzsSVktDvrPDWPHqIjJmQAPar20MWChtyY7C4vQNDG3A5StA+4zmqNEFUwbHb6jjtvFWqZiVEXmTKk6XzivZrpowsfE/TyoDwMZ5yLUHp4MHA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH5YmcxfrQNowQFSopjjUOiewEjJbND/qb9R5mqqu7w=;
 b=e1tvJBooeG6sKSwySB2iR8NNjZ0ly/eXKgsELxr8f23EA3S3+7iWGMoZMyLjHrgI48yFo9F6r0YBzI4v4gS4B3mCbWYYYxPzGpXi62Emd5drnI0H68LrAisWtovhYzQdxn07LwhAsTVMEH+ZmpruuStW0iMSLg1IXsTu6YnOQ/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:11:50 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 10:11:50 +0000
Message-ID: <d62a1b46-d44f-48b9-9f93-647fe2a6f8a2@amd.com>
Date:   Wed, 8 Nov 2023 11:11:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, palmer@dabbelt.com
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
 <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
 <20231107-darkening-daylong-deef34169798@spud>
 <872007e1-6e57-4dc4-89f5-62fea3c969a5@amd.com>
 <b1b5b020-600d-48c0-aec8-c866c4c29c7a@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <b1b5b020-600d-48c0-aec8-c866c4c29c7a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: ea04c8c6-c445-426c-933d-08dbe0431fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDLV/6QhIrs6OfqYNZlrZvcx+uhR5BmtJFC23CEsjNPHD6UMUXXpINFkv1CKKzRoa/YkQFZJV8m1CfbvCTaj+06QnCQrNnQCdPvUHSwN9FZG/NAX4cMOAduUioB+ihPaOexzpqgC0qvlIdgFLNXDU+cjJGiPCTl8NUb6kmvGvLxLKfyu8cZtT/i88RJB2eFHsiCUQbJ/PcRLI4ZgXG7/41WVMFNdAcTxh+b6KvQrcUO8x69wEeuyrRcJSbcBO1OtXq/sbWx4HoxeaTxmmqxaG3NhIjwcBsb7w4+qqw7DKjx3Kz9tYT8ciBDgKCTNHysIWMG3jYHd99TB71S6ux45XNAlO+1SnvF7UP9hFUBU7l0E/T2wl+KB3Ev5yuMOOK5eJIDnfrA1Mb8xczppx5gAmxukdymlBinipON0HC+atcdN7HYerPu89pXtX93/NgJTiMseIOunzsYFAopt1LmE/Vnv2LMW51XyNH+taJQaRVdFAErb8nihYX4cGbBydBnyoxcFTD3sHszcJDwVR0kFc+0o7NW2CYqttpkFW34RyoYa+AW3qmnfEklN26sy1dpP6Iu0RYOIlWyviksshaErvlzwWMOp00nA9E4kOevJH8DFBZ+m3gYpRWoYusBon6XFUJV3OjwDvRTffNkuQvjG6yKkXvCsXVCs13z0wGpp/Elksw9NEodGCr/MfrtDznSk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(66899024)(26005)(83380400001)(2616005)(30864003)(38100700002)(8936002)(44832011)(316002)(4326008)(54906003)(8676002)(2906002)(41300700001)(7416002)(5660300002)(36756003)(110136005)(478600001)(53546011)(6512007)(66476007)(6666004)(966005)(66946007)(66556008)(6506007)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWt4YnVSM1cwNFBUM0pIZmhLV3NkVldwYmtBVGZySko3WW9oRlM3K0toTzJz?=
 =?utf-8?B?RzZNc2UyV2h1Sm1CbW0vUUZ5QnRlMnM4RnhGeUJzc3FodTBSOHhydlFqVmM2?=
 =?utf-8?B?QWJGTUphWko0emRXaTcxYUpPUTg0dmlHcVdzbTlUNUpZSFpHUjBlNDdRL2E3?=
 =?utf-8?B?cjVPWUMrbEp4Y1Jza1YxRFFsNVQ4MDcydDdyT1MxL1RpRkRhb2p1TCtsTi9m?=
 =?utf-8?B?c2tyZUhick1ZOURmcEdUQ1FPT29YUHRadTAyRC9xSnZRUXlJR1FoMUZLUklo?=
 =?utf-8?B?YVdxSmxreEhzRWNKcHhnV1B6Ry84TllRYUNZQWl1OFgwbFI3WjFoeG9xNWYz?=
 =?utf-8?B?RHBxeW94TVpFdTVWUTNjbDVRd3lxb1FLdWxmRjJqeWJETVhDUEtTaHpLUitl?=
 =?utf-8?B?bCtwWkJwQlM3VWpHRUJzZzBDT0FFR1FnVHpFZmhRS2NPMDZCTEdPbzVWdktD?=
 =?utf-8?B?YVQvMVU3dC9ZMUdESnNhZy9YeDhQbVVsbDJ2WTJnU09aZHROK1I3WGFrRE10?=
 =?utf-8?B?S0d5SEJQTVhiZXZ4UzE4dUpubFNBMVRzMHNxMFE1S1NNVEFweFZwWkdYRkow?=
 =?utf-8?B?UUY0OUFXWjFvR25taTlDR2tXNkpxREorUFJMWHhkV0Fndlh1b084RUZCWFVK?=
 =?utf-8?B?d0pFcVFJTGRUVkdLU09Yc3F3Y3o0SDZDK0xIMTBlVzNmTWVPZmE3ZXRRMkFs?=
 =?utf-8?B?UXBhTHJjUUZwL2cxU3Jlak5XZHh5VzJzell5WWJZNFNxelFtMTE3dXlDaHZw?=
 =?utf-8?B?YVB0ZkRkZXI2Q29nRzIyNXF2Zy9VcnI0RFhjTENBbGYzKzI3NjhOWFQxY3A3?=
 =?utf-8?B?NVNXSnlWSGlTaEdoanBHV3pGeGJQeGNiMU5HdFRwK1BWbFZuenZ0U0hiTDh3?=
 =?utf-8?B?NkZwT2JDam5TaWlzcnY5bTlsUW5FSEwxUjRTRlBkaFo1Yi85QzdwY2Nmbis3?=
 =?utf-8?B?Q3RVL1VZS0VrUXZTNDN3eXRvWnV3MVk0dG50cUNvYm1STjZJNldLVm5QaGVw?=
 =?utf-8?B?Vjd2TVh5K016VzU1S1U1V3Zwbm4rejU4QTd4ZzRVWE5EWU1IWFFpN1Y1akt2?=
 =?utf-8?B?aWlBR1BNbGNIOFJjTXIybEJ1eE1kZmFXKzAxSnRVNVpsNHpEUnVVclJoVEc4?=
 =?utf-8?B?OENUZWdJYWRyaE8yTitmN3Y0eTI0cEx5djBvWGdrdHptejZyMHMrRnBuczcr?=
 =?utf-8?B?UU1zTkNxa1I1UTN1Z0NLTmNwZ3dCQ2s1NERDYkVic3A5enlYVElUM1M5alNY?=
 =?utf-8?B?V2EvMEF5WTlITmJKY3hpRmQ4Qm5MeUNQRU1KWXFOaDBiTDR5NWFoYXhQTzA3?=
 =?utf-8?B?SzNObmtlYllHY3Y4S25vNlp0ZThQVzB2WnhwclNIb0Z0WTMrNjA5QzdaWS9q?=
 =?utf-8?B?aS9mVlF3S1BTZXRIR3dxeXFLNlRXeDdOQy9FL1p1NVpiRnoydUZjb2w5LzVE?=
 =?utf-8?B?NFF3bGpoRThLOUNKM3pHTG5wMzNaQ2MyY0xTUTNsajFkTGhrWUl5ejhLL1Zy?=
 =?utf-8?B?L1lkSTdKamM3USs1UFc5d1BGbkNncGFYc2xlLzM0VFFRd28yQ1YwQXNyZnp0?=
 =?utf-8?B?bEk0eTkwcFpremxoT29LNTdYUlJtRHJ5bkdpZ2w4YjRVdVU3VGxFbUM2bnJt?=
 =?utf-8?B?K1V6eDNwa21aMEVZd2tPMk16QWNidFAyNzdVa1VPdGxNeGtXc2JweG9iZEZh?=
 =?utf-8?B?ZEU5cmhPUklLc0RuVytWY2txQ2s0ZVFYMjBzWFZUUEZKK1hqaktmalljemg2?=
 =?utf-8?B?eUhTbDRKQlYreGVobWx6bEpuM0JnYnQ0b3pFYjRCckMrcWFtbHNPYXZ0WGMx?=
 =?utf-8?B?ZHZXcjB5OTJmWFdYc2hBdWF6YW83L05TTkhCb2VOcjRja0RXSjZnTDNYOFhC?=
 =?utf-8?B?TGFRNnY1c1oySTQwVGEwS3RBa2hEdmY2M29WZXpoQVpCdUhNU053UzExMHNo?=
 =?utf-8?B?UklPY3Ryc0dDZWQ1K2F5cWtZcm5BS1l1T3lQNGdSbkM1ZXg4czgwcU13RkJp?=
 =?utf-8?B?c3VvYzNtUDRPdS9VaVJkcDV5dHExYUdRVlVHUnJJK2VmK0FYZlRmZ0JLY2E1?=
 =?utf-8?B?WTUwVi9MNTVZOERiY1RKU2RCcVFjSUdnbkVzVFEwRE8wZ0JHTU83R0xjRW1Z?=
 =?utf-8?Q?WbKXZ/vxbrLPhB2ik6FHPwMxM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea04c8c6-c445-426c-933d-08dbe0431fc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:11:50.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05/IELSnIxqicbJALhNJZ59eVYIBAE/rl3Z07o9LA7IM62rA0NiHAck4ZbOuElGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 09:11, Krzysztof Kozlowski wrote:
> On 08/11/2023 08:16, Michal Simek wrote:
>>
>>
>> On 11/7/23 22:36, Conor Dooley wrote:
>>> +CC Palmer
>>>
>>> On Tue, Nov 07, 2023 at 01:38:15PM +0100, Krzysztof Kozlowski wrote:
>>>> On 07/11/2023 13:09, Michal Simek wrote:
>>>>> On 11/7/23 12:27, Krzysztof Kozlowski wrote:
>>>>>> On 07/11/2023 12:09, Michal Simek wrote:
>>>>>>> On 11/6/23 18:07, Conor Dooley wrote:
>>>>>>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>>
>>>>>>>>> +description: |
>>>>>>>>> +  AMD boards with MicroBlaze V SOC
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  $nodename:
>>>>>>>>> +    const: '/'
>>>>>>>>> +  compatible:
>>>>>>>>> +    oneOf:
>>>>>>>>> +      - description: AMD MicroBlaze V
>>>>>>>>> +        items:
>>>>>>>>> +          - const: amd,mbv
>>>>>>>>
>>>>>>>> You don't actually list any boards here, but instead permit having only
>>>>>>>> the SoC compatible and no board one. The SoC compatible is also
>>>>>>>> incredibly generic. Personally I don't think this binding makes any
>>>>>>>> sense as it appears to exist as a catch all for anything using your
>>>>>>>> new cores in any combination.
>>>>>>>
>>>>>>> I think I need to define any string for compatibility because it is standard
>>>>>>> property. Because this is soft core it can be added to any board with AMD/Xilinx
>>>>>>> chip. I don't have really an option to list all boards.
>>>>>>
>>>>>> Why? Either there is a product with this soft-core or there is not. It
>>>>>> cannot be both.
>>>>>
>>>>> I am doing basic enablement. I am not making product. Product will be done by
>>>>> our customers using this core.
>>>>> There will be thousands of different configurations done by customers which will
>>>>> have products with it. Also there could be hundreds configurations done on the
>>>>> same board.
>>>>
>>>> If this is the same board, then why there is compatible for it?
>>>>
>>>>>
>>>>> Does it make sense to have board related compatible string like this if this
>>>>> evaluation board is used by a lot of customers?
>>>>> "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"
>>>>
>>>> I miss the point what is the hardware. Evaluation board is the hardware.
>>>> If someone changes it and makes a new product, it is a new product.
>>>
>>> To me, this does actually make (some) sense.
>>> The first compatible is "soc" + board + design.
>>> The second is "soc" + board.
>>> The final one is the "soc".
>>>
>>> I say "soc" though, because it is not a single soc - it could be any
>>> configuration of these soft AMD cores on an FPGA in any quality,
>>> possibly set up heterogeneously too. I don't think trying to define a
>>> generic compatible for it like this makes sense as the soc part does
>>> not come close to identifying a specific device.
>>
>> I am fine to skip it but it is required property which has to be defined somehow.
>>
>>>
>>> Until someone actually creates a product that ships with this, I don't
>>> think it makes sense to try and define a binding.
>>
>> I disagree with this description. I am coming from FPGA world where it is too
>> late to start to deal with dt binding when you have a product.
>> You are saying release the product and then start to deal with dt binding. When
>> product is released there must be stable dt binding.
> 
> I meant that creating a binding for something which is not and will not
> be a product does not bring any benefits. Why do we even care to
> document it? Who requires it? I don't. I don't see DTS or driver, no
> need for compatible.
> 
> That's why entire discussion starts with DTS (and/or driver).

We have dt description for soft IPs like uartlite
Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml

We have 16550 compatible IP with
Documentation/devicetree/bindings/serial/8250.yaml

Simple ethernet core
Documentation/devicetree/bindings/net/xlnx,emaclite.yaml

Axi ethernet
Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml

Adi clock generator
Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml

Adi fan control
Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yam

Adi adcs
Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml

and much more.

They are IPs from vendor catalogs. We can talk if it is a product (definitely 
yes if you need to buy it for your design). But all of them fit to the same 
category that you are composing your HW design with them.
All of them as standalone can't run. You will never create a product with just 
uartlite IP. You need to add cpu, clocks, reset logic and others around to make 
a product out of it.

Our mental model is HW designer create new IP, we are writing driver for it, 
customers can buy it (or get it for free) and use it.
They put it to their design, create custom board and sell it as a product.

And in this particular case HW designed create risc-v compatible CPU.
I expect this should fine
https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com

And discussion what we are having is pretty much about how to share the view on 
the system.

>>
>>>
>>> I spoke to Palmer a bit about this, and what I think would make sense is
>>> if you had some sort of "reference design" bitstream that people could
>>> download and run on xyz AMD devkit. If that existed, then we could
>>> document that configuration etc. Otherwise you're in the same spot that
>>> a lot of IP vendor stuff is, where without there being something that
>>> qualifies as "real hardware" using the core, it doesn't make sense to
>>> try and create bindings etc. It's the same for the various people in
>>> the RISC-V community that created their own CPUs that they run on FPGAs.
>>
>> Aren't all ARM FVP models enabled by SW before soc vendors put them to a real
>> chip? Is there any real product available at that time?
> 
> FVP also finished one. They do not claim they added compatible for a SoC
> or CPU. And that's my impression here.

Are these real chips?
         compatible = "arm,foundation-aarch64", "arm,vexpress";
         compatible = "arm,fvp-base-revc", "arm,vexpress";

FVP are Fixed Virtual Platforms. Pretty much emulators similar to QEMU.

> 
>>
>> I will try to find out if there is any official plan for releasing any reference
>> design against any evaluation board with commitment to supporting it.
>>
>>>>> Or I can define qemu one.
>>>>> "amd,qemu-mbv", "amd,mbv"
>>>>
>>>> QEMU is not hardware, so not.
>>
>> I am still trying to wrap my head around it. In qemu we are actually going to
>> create model for this configuration but based on what you are saying here we
>> shouldn't really have DT which describes it.
>> That's why we likely end up in situation that qemu create DT description self,
>> put it to memory and u-boot/kernel will consume it. The only difference is going
>> to be that DT will be used but won't be checked against dt-schema.
>> I personally prefer to have DT pass dt-schema checking and tell qemu guys, this
>> is what qemu should generate.
>> But if you think that this is wrong approach I will let them generate whatever
>> they want and will just check functionality. It means u-boot won't have DT,
>> Linux won't have DT and I am done.
> 
> 
> Sorry, I am confused now. Are we talking about real hardware or QEMU SW
> model? Your description clearly said:
> "AMD boards with MicroBlaze V SOC"
> so QEMU is not a board. Board has a physical form, a shape. Usually flat.

Let me describe what we do for all our SOCs but Microblaze is the best example here.
Customers open design tools (right know Vivado) and design their system there.
Choose cpu and it's configuration like barrel shifter, divider, multiplicator, 
size of caches. Then put there interrupt controller, timer, consoles, ethernet, 
spi, i2c, etc. For all IPs you need to choose mmio base address and connect them 
to any interrupt line you like.
You normally target a board, evaluation platforms or just standalone chips which 
you use on your custom boards.
And build bitstream (configuration for FPGA) and also going over our device tree 
generators which generate DT for describing the system.
Very old example is for example visible here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/microblaze/boot/dts/system.dts?h=v6.6

Another example is mb-v description mentioned in previous thread.

The reason is simple with a lot of IPs in the design none will be able to get 
description right in connection to addresses and especially interrupt numbers.

It means at this stage you have bistream for your board and you have DTS 
(without board specific information like i2c devices, ethernet phy, etc)

For 10+ years our qemu is taking input as DTB and create qemu model based on it. 
It means you say via DT I want this cpu core, this timer at 0x..., interrupt at 
0x..., uart at 0x..., etc. and qemu generates model for it. Pretty much the same 
DT can be consumed by SW to run it on the model.

We reached the state that you have qemu model which reflects your design choice 
and at the same time you have hardware for your board.

It means same DT describe qemu configuration and also hardware.

>>>>
>>>>>
>>>>> I think customers should be adding their compatible string in front of generic one.
>>>>
>>>> To what? To evaluation board? Why?
>>>>
>>>>>
>>>>> Years ago I have done the same thing with Microblaze where compatible is defined
>>>>> as xlnx,microblaze only.
>>>>
>>>> Again, what is the use of such binding?
>>>>
>>>>> When customer take this soft core, put IPs around and
>>>>> create a product they should extend it to be for example like this.
>>>>> "xyz,my-product-1.0", "xlnx,microblaze";
>>>>
>>>> So there is a product, not evaluation board.
>>>>
>>>>>
>>>>> And over all of years I have never seen any single customer to try to push dt
>>>>> description for any Microblaze based product.
>>>>>
>>>>>>>
>>>>>>> I am happy to change it to something else but not sure to what.
>>>>>>
>>>>>> Alone this compatible does not bring you anything.
>>>>>
>>>>> I don't agree with it. It is standard property and I have to define it somehow.
>>>>
>>>> The property is already defined, you do not have to define it. What you
>>>> define here is the value for compatible. Why do you need to define it
>>>> somehow? Who asks for that?
>>>>
>>>>> If not, I get an error.
>>>>> .../xilinx-mbv32.dtb: /: 'compatible' is a required property
>>>>
>>>> So you have a board? The patches must be linked to each other, e.g.
>>>> preferred way is to send them in one patchset.
>>>
>>> There were patches sent to U-Boot for an example configuration:
>>> https://lore.kernel.org/u-boot/d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com/
>>
>> thx.
>>
>>>
>>>>> And it tells me that this risc-v compatible core runs on AMD fpga and it is
>>>>> compatible with it.
>>>
>>> Basically, it provides no more specific information than the cpu node
>>> does. From me, it's a NAK for a compatible like this that that permits
>>> using it in isolation for any core configuration and combination.
>>
>> I hope you agree that if we ignore compatible string for the whole DT that DT
>> describes HW is very reasonable way. It means you know what CPU is, what timer,
>> console and intc are.
>> It clearly shows how MicroBlaze-V AMD design will be done for others who are
>> interested on using it.
>> It also shows and explain what drivers needs to be enabled in defconfigs.
>>
>> In connection to above u-boot. I can simply remove DT patch from that series (or
>> move it to readme) and just say these IPs will be used that's why I am enabling
>> them and point them to public announcement. And configure that DT will be passed
>> via address in DDR and that's it.
>> But I simply think that DT is providing better view on the system.
>>
>> We will of course extending our device tree generators to provide DT description
>> directly from the tool as a starting point for customers.
>>
> 
> 
> You called the file:
> "AMD boards with MicroBlaze V SOC", which means "AMD MicroBlaze V" is
> the name of the SoC.

It is official name for risc-v compatible core implementation for AMD/Xilinx 
FPGAs. Strictly speaking just name of cpu core.

SoC is cpu with other components around.

DT is describing one of the configuration with MicroBlaze V cpu core with 
related IP (timer, intc, serial) which together create SOC.

World boards is likely what should be fixed. Maybe design should be used instead.

> Now you create one compatible, not a list, for "AMD MicroBlaze V", so
> only for the SoC. That's the discussion about. You cannot create a
> final, real and working hardware with this SoC alone. To make it
> working, you need to put it into some board. 

I can agree with this description.

> Now, for SW models,
> probably you can... but then how do you run it? 

I can put this sw compatible design to thousands of boards but I can't say which 
one. As of today this SOC configuration/design is built and running on kcu105.
https://www.xilinx.com/products/boards-and-kits/kcu105.html

But in very easy way it can run on ac701
https://www.xilinx.com/products/boards-and-kits/ek-a7-ac701-g.html

> If under QEMU then show
> me the QEMU machine file - I bet there are some specifics for this given
> configuration. This means you have specific configuration, not a generic
> SoC.

But I want to show it as reference only to see how that DTs will look like.

> And again we are at the same spot as with hardware - you could not
> run the SW model without configuring it, thus you cannot run a "SoC".

And in our case we use DT for SW model configuration too.

Thanks,
Michal


