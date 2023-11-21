Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19577F2675
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKUHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:37:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08BC1;
        Mon, 20 Nov 2023 23:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc9lsauh+RV+dbt+CRXP8ucfzXicfDxozCthKbIeGYiUqzV3+efHQquCqUpf2nmtBQ6j881W+4y+vAFy0Kzj0D4otkCD2KmF2hlEjFIWBN9x56fiYNvarV+AN1dqr4cQKkOK07TVxw1J4d8UR0VLvFJNzrTnyH/lddIhFWER3oV9MKdjOeH3GR6jvBek9VKXTN3fRppvQHpqGFAM7Lk3aXOf+8Pa1q91k7sDh2tu+H9XcRPB8Iw6LT3a+0AaeIFhMHi8S+ODzOTMze6EFydlYKGu+1p+TeFn/DXZ9RPX1A1uSeN1I1TKXt3UEUqZjX6j3jKBmCKHrGCphf9ZbK59sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP2v+H9doDdUMjvWBs8tFinftSG+73sJ/jqBVPItVA0=;
 b=K2RfUZrikIvz83JrDVo74PyugZnb4h/mkEJH9oaWPl8U4JiFo00TW50w1nVNsse8+Zkbczc/b9gEKxllMr68o6bAp7f9amhX9nYoi8vDCk683abzyWAIdG4iOju4y3JGkiXdQgLldkag3DeRxAxw6wZKaetJ/tpzf4I8O2/hNNEV7sOHkPTpsuHRH1sKsfRfCZelJRZYcIbQqPyBK7kceNFKFRKgz7+zw+1+am7Y1LJK/23ekUan8nD72hRz5lMpyvX4Fa5WBSKO6Kt5VD+yVS1DT5ljj1cvwSx3NCIUXWUD7HoWBUw/NsJUR7083TfRpgvynpXcOf/2S16ouTs9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP2v+H9doDdUMjvWBs8tFinftSG+73sJ/jqBVPItVA0=;
 b=jFiaPOTXyP1PGG/14Fi+1RLgb/spDYS84p7MzsQov7x/0wMhIlUhjKd6XJNNPFFW0kAh1AZGPIMOKDbEF8oGFr3F/0JUluNyuOKrVRAL3EPdYLwFp61zzQENmB5Go0+zgBCXqbYarK4LFF4awLCxkKe5ze3mt0jvHK3BEVKXCSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:37:05 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:37:05 +0000
Message-ID: <d6051482-377b-4da0-ac38-716918985a39@amd.com>
Date:   Tue, 21 Nov 2023 08:36:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <14c3900f-8f2e-4614-8317-f85763d1d953@lunn.ch>
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
In-Reply-To: <14c3900f-8f2e-4614-8317-f85763d1d953@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0268.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::41) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b4bb6f-2c12-40e0-0594-08dbea64a8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKhhB8H54UX17TuFBUZa044fKpvwgwYwslogpfDk+D7Q+RXT2ha/1BpnHazkyl1e2z/OSh7e2Naz8txScVUokG5u3h+UMlRxT/Fh58ASIY7wOrY6VHOOv2qu5FaoDapjKnOK0kMQ6m2yI7eHsGefGM/kq0gU16u8NRUG8Ypd45hhKkj0TGzrQuTZCN86qOOGQ95HJnVw5nPDzbUrSzRy4eqjZDhlsftPc/UK0HFTZ5SzfwwD8gsdjXcYdBe6PYyT9oj4hgigEZpkNojQg4cbeBqsqq8Fvai3kjGilMwONsDF7Mj3JQ4xdZMLTF6wvwNGFavFVYQkGtSFaiUEbuZO3O7RWtVrt69Q9jK22KANx7BPDK/gSpyUvMJcowjQhUmV/iYOGKRbltSHQM6IbeCyTC1s57qGGJtMyLPAzFBBug8zJqRaRYO/al7eOVdKL0QelTuC+B2rX2ejh5/OrLYnX/qpCwc2Tj/h2XT2UjdTbLrE7KMMLG+lOSD3S6Ye9qON74Lxh1LFYK7bWswk4y62/Q1/RsVR65QpHqvcxBX9yKyxQl91UaBCvamBi1PtYCCYyxPo9zA/rfnyNUrrQ68D1ISIfS4qNGALU/YZIkn6US2VYXYjmK3gV1udG5HEZyGi0pi8FHMY3F/j3YLR/EZWlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(66946007)(110136005)(316002)(54906003)(53546011)(6512007)(36756003)(6666004)(6506007)(2616005)(26005)(478600001)(6486002)(38100700002)(31696002)(86362001)(44832011)(5660300002)(7416002)(31686004)(2906002)(8676002)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uklid2VTNlZnc25KdUJCcU1VNHhYRHZXSUZrR3BTZExIODBVQmQ1VmtHSnZi?=
 =?utf-8?B?c3NucWJPT0NCSG9HbzA2aHA5c1I1Uzk0UUtIRjZTMGk5TE5SbkhBeFRjTktu?=
 =?utf-8?B?eHZuSXE4MDhiSzlrOFFQdjQ4ZXpEWm1Rd0RJZzlQMmFGeUxhZnZUdzREcEhH?=
 =?utf-8?B?SnJRQ0tiQ0hwUkNlbGI1eEJqeWd6RGxLVVFka25iRkJJZ3BTN3FmTG51Tk9D?=
 =?utf-8?B?TTNrZHVhUzl5bGlkam96RzJMbzNZUVlEYWlpUk04VVlQa3V6NVg1WTZpSWFq?=
 =?utf-8?B?dmg4L050aEMyUXBHVGRoZ1R5T3FtZGFncmg2NkltanVjTkZ5VDRrMkJudGJ3?=
 =?utf-8?B?ZnM0YlppY2w5UnFqS1VoWCtNVDFjVHlnN0xrbDNKQytHQWNQeWtGcnBjUjFC?=
 =?utf-8?B?MU4yNmZ1TUdSWVBGRjNmcUpvRmx1SjE3UG9jT1AxaHdyeUFIdm81Z04yN0dK?=
 =?utf-8?B?T3I0Nmx5UEhFZmpoaWNvenFkQlJyMnp1RTRGS2drSXk4c1lIQ1ArSmoxYWpk?=
 =?utf-8?B?RVdDdEQ4MjVZQ0lPRzlLS0E0YnFrWnZjZlA1UjBPVUU2RWRyL2ZnbU9aV0FF?=
 =?utf-8?B?YzNvaCtTb0J6cnhvUGJFYURiL29RQzRSRVNDcHNDcndlSVVxakhHaGZQdXRH?=
 =?utf-8?B?TExzMmlxY09lYXJRWUhaSDR0czgxYTFSRW5tWno0WC9BUjJHRjNvYzRNdnFQ?=
 =?utf-8?B?S2xYdFZqQTl3Y1BJMU5CN2hyaGc4OW5HalIyb0dubXFqOFNrYTJBTG91d3ln?=
 =?utf-8?B?YVZGUkJHRWo4MDEwRDI1RkRpT0pZMUEwaW1NOGtaNHAyczhjelNtVU1CVDlF?=
 =?utf-8?B?Y01JUXhEazJiTGZRWVN4YVpTN1NvZDRTaTQyYk1TVGpGdFFJeHlrTXBac1k5?=
 =?utf-8?B?cmlmZyt5Mkdia1FLNmFZNG1iTVFsblp4RGFwLy80dC9wL29CNmtZN05abGRw?=
 =?utf-8?B?d1A4dDF4blk2NjlEVVRrVk0zcFAwZVIwZzdBTkQvbE9jZFB4cW8zSC9VSDBK?=
 =?utf-8?B?VlUwam51d29Cbm1maGwxQ2pQWHhPZG00QjJoTFBseG1pZzBsazJwRWlXNXZk?=
 =?utf-8?B?b0s1cFlPMm1NOG8zWVhmWWljbHdUUjlXOWhDOEdvMkFmOW9LeUNKUFNnMHJi?=
 =?utf-8?B?QVp1QytPQ2ZSeXh0L1dkN3dnRWtCa1EwRXBWc0FzcUswUWxxeGJNOEo3OXdD?=
 =?utf-8?B?MEYvSlVxeFFYdTBIYWY5SFI3ZG5FSTdEVFl5SmY5V1F3RG5pL3hHV2p6ZGcz?=
 =?utf-8?B?YTJRaE1EbmVFb2k0ZU9BeU9nTjVwT0xyZlRuUmNLVitFRllIR0c4bmhpSUtG?=
 =?utf-8?B?bzlFbWdrSWozaFdqR0t3Z0laZVE2NERGL2JXdnFmcDBPK3h0TisvZGwrVkJG?=
 =?utf-8?B?cWVrOEo2UjYvTFZrdXBGbDRMUnhaeXRKTy9xNm1rVkZoWW4zRG5wbjlDRUcr?=
 =?utf-8?B?dGptVEs2dm0vVlNlYy9WVDFZVjN4K0NtTDlyemtWa3JyRG1JeEt5cmFFRFdO?=
 =?utf-8?B?SHA2MWs4QStDMDN3cW9hbWJmU3ZVck5razJwY2F1TFRJU2RvZWlaM0QvakMx?=
 =?utf-8?B?MkorTVFDTnBDMlhOTVVmY1VSWTFucHpZd2FGZWQ4ekRJa2g5ZktOTzlCamVS?=
 =?utf-8?B?dUthd0kxZXJrdkhEUWxDdmQ4M3ZkSmdqZFdWUU9sNEFxUkJHVmh3N3NEdjFR?=
 =?utf-8?B?TnBHU3dMNldXVThZOUtyc0JHdVB1dERRQVlldHVxVE5lTVk1czI2QzMwMDU5?=
 =?utf-8?B?VlBlS3lBcEJnM1lFdmRKQ2xnbGVheXRlUk4xbzd6cURQREM1YnArdU9kc2tL?=
 =?utf-8?B?Ris1VEJldGlWWjBaanhwWVdPeExpVzliU0ZlK1RSMmVMNHduVHlCVlEwM3Ev?=
 =?utf-8?B?NzZWaTExYjUzWjBPQ1huVXFpQi9LNCtGVHJ4bFRUTVgzM2svQ1JwT0Z1MVBU?=
 =?utf-8?B?bk53ZndOZ3FLMllhT3FzNmlHVGtPQ3dVRHd1WTdzTlJuaytmUEF2YUJFa2pY?=
 =?utf-8?B?eVhHckYweTdLK3B4UXVOendmNm9JajBQS2x3Q0p5ZklsNVRIZ20rZ1FHR2N2?=
 =?utf-8?B?QVFrTEhaOTdxcnRVYkhoa2hZVGlLUjg5ZnhpRGFON0ZFMFdoUlVaZFo1Njgz?=
 =?utf-8?Q?RHF/g7mBW14//x+TLl/qQ1VrW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b4bb6f-2c12-40e0-0594-08dbea64a8b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:37:05.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwC0yt/hQ3F/YpFxdxVr+4SDyKPeGEAOYseJQYzH67j3PcinrFFRhYi3/dPLXSDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 21:15, Andrew Lunn wrote:
>> +Naming and Valid Characters
>> +---------------------------
>> +
>> +1. Node and property names are allowed to use only:
>> +
>> +   * lowercase characters: [a-z]
>> +   * digits: [0-9]
>> +   * dash: -
>> +
>> +2. Labels are allowed to use only:
>> +
>> +   * lowercase characters: [a-z]
>> +   * digits: [0-9]
>> +   * underscore: _
>> +
>> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
>> +
>> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
>> +   part can be padded with leading zeros.
>> +
>> +Example::
>> +
>> +	gpi_dma2: dma-controller@800000 {
>> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
>> +		reg = <0x0 0x00800000 0x0 0x60000>;
>> +	}
> 
> Hi Krzysztof
> 
> What i like about the Linux Coding Style is that most sections have a
> Rationale. I like the way it explains the 'Why?'. It makes it feel
> less arbitrary. When it does not seem arbitrary, but reasoned, i find
> it easier to follow.
> 
> Could you add rationale like the Coding Style?

+1 on this.

Thanks,
Michal
