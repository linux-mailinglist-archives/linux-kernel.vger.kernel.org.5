Return-Path: <linux-kernel+bounces-9597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79681C833
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51091285D14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38817995;
	Fri, 22 Dec 2023 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXWrThBO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF117983
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI4Fk9IbxTXrhxM3AS5q6ozT0j+a85E9jOS2wptkjy7bbBZJ0C9jw3bWB7cWOLCLeyGRiQfBL3CMSdnJ79TSFzBycxxZOiaRvG3YMqevJAiD7mLldUwwv1lKsIQb4wy6E1FGuNE08/0oiRVajVIoRUFV2fSfGhlQlSqBiUhDedmZZ9Jtgc0oQLoFl1eBW8B7cUXbIYVxrchxWPL7nfQlz/M69k+Eg9XrBkGiBwpHZeotI272+UAmAokSG0i0uWjYNuiuwoL+tmz/AcxkLQqQ3MLwvZJIYEaJ6AKtaXzwK/QVnvINArLm08SgeVDX/MdRKNsID9kDnrnOn/5dOd5PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PngxHrAC8bClSnrJLE4S2cFPw1dgTk5Xz50wCz+a58=;
 b=lRJeYl6KpAp83c/ZO+BtmKa7/t9g69lzbuUttOfVpKAtbEjYoNJuMI3CfEOL2y1/Ks9X/YAGFde5gry7hphh7B1OSpTfIAhYuPxEhGv8sEDcSYiy278buRYIKeqQSPQkw4ooauQPVpd7snxUxdqUWy1MSoqcQ/v5PHHuw5B+v2vZ7drbv8+uM0jETbC0iQ5otqu0SeEAvQOs40iwv08/s63hcUKVV//yZPpLG5jMngYK0KOwypUojz+Z5sZdePVC4bic3+jGv/Uvm8MmOxaRqZ2TElU3x8v7IQnRrfsfECJVv2DB0NEwpsZVVzloO+cDE/VqHLkDbEkaSVT0SkUArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PngxHrAC8bClSnrJLE4S2cFPw1dgTk5Xz50wCz+a58=;
 b=SXWrThBORr0b8PVyYVItrquE7S5nOUUKHr995IthOeL/yBMGx1FyG2ggUHT7WtjcMyfiBhJjee4FxFgfhz37PhMzS7FzrPruRfKRlhCM6fZfMGcletFWp4Ymy4Fh0UmUz9wnEi4k+FaS5yT/fY/T44nF1G6EDUOHE91vlworVZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 10:34:48 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 10:34:48 +0000
Message-ID: <0ab000c3-be7f-41f3-8017-28738cf0a698@amd.com>
Date: Fri, 22 Dec 2023 16:04:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
 venkataprasad.potturu@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-5-Vijendar.Mukunda@amd.com> <ZYRqEbVADgU4fNtB@matsya>
 <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com> <ZYVVD2mL5kAePXDE@matsya>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZYVVD2mL5kAePXDE@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::14) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd0c194-ce06-4572-0379-08dc02d99f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x4GyJEn6wAW0CJJH117cUIX2qLhxGoaXiqWucSAv0BSCUWy0p/BLCN/WqnkqC/0ZvJzkamLfmClwoiuGlqDk8EDG16az8NXQjswk51tIwWnNpfS1/+I18/OTqeG2iKKS3Ha04byBoX9qJySRa4shSoCCFQV+XWN1REMSur4BQ+JL6bby1WJp+GcDgOnbEpN1MW1cAAk+1MY18bQ0rMhwyZi4UMCwLxlnUl9y3e2xs30oMrf+idojHdCHzx9tT77eUpfqDMFGR1J05dI3enLES/9CYSFwWuxSRXubYu3T+EKmIRQ544yV+i2wbFQ2KnXk8DwOYpA2XYhnbF9cABKv7mhEWDZ07U2EuxUmfupGpZN2tuXYKps2iGxkc+aiRAwYvjOWwnH3Wwyqsp3NOZkqOQ5XCH7rhK6woPgALCbrCVSO0gwfSp9GVjAsJyBIamQQ8Oyp1s4PW/iAP0LT5F0AWZ6/jKd4B0Adxm2mS67Ru3ivsw/9qdqpzAN+xR3R/MZrr63z2aF+uyfCVzjBi2568V86nFfmKsOEyrItRHoxMmn3DknFRWISoNHty8ELUwHPgN1V/4DgVRLEFCS6u9lcKh0NyDqsPQjRkmvOCqQZgdlm01LNjP7LHWCE32NrO6SfIx9E+bQu8fZ8PBp9xbmStg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(6666004)(53546011)(6512007)(6506007)(478600001)(6486002)(31686004)(83380400001)(26005)(2616005)(4326008)(8936002)(8676002)(41300700001)(2906002)(31696002)(86362001)(36756003)(38100700002)(4744005)(66556008)(66476007)(66946007)(6916009)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXVrTWZSbWt2TnVHWTlnTTZuSFpMOGVVWVY2WXdSWENTclZkUlRsWHB5M085?=
 =?utf-8?B?MnFBeVIySWx6ZXkxS1lpSVEyMmV3NHJmYUFqUmhSblNFSTFuOFVsOVJidUI3?=
 =?utf-8?B?Z1dMSEVrR3lCUy9sRVJQa1lsSlNnZGhNcUVZK2h5WlRtSUFsWENCaURjK0ta?=
 =?utf-8?B?SEhRZlpMU3BMQmRaWFN0Ym1KY3dxVWJ5YkYyTFVnRG9pc0JLWXUxVUw1SzJ3?=
 =?utf-8?B?c3Jnd2xaK2JKaUJoV0dVWXNIOSt4bm9lQjJjL0ZiQ1M3SW12QXpMQ0picTF2?=
 =?utf-8?B?c0ZuUVFQTUxBWXFWSklwT3Y3enhubTdnUjRYQkdKYVhuSlFsM2ZHUEljN1ZD?=
 =?utf-8?B?ckFHZ09UcGtqOTU4WUJ0Mml1eFFJT3BMZGdYRzNBYUdYQ3hjbTNKa3c0bDFO?=
 =?utf-8?B?WDZiMExlRGErT2JDRXhKTitlWVN0QkQyaWE4d2MrN1hrcmU4azVnbDFsNHdE?=
 =?utf-8?B?em5lWHZkaktYZjBWbDV1dVpFWEhTYTJFSGt3KzM0SnVnbVZRSTJUa0RLRkI1?=
 =?utf-8?B?c1MwZ0hSQUhaNUlnZkV1dlZOcUcxdVlsb0dieUxOUGh5MUtUZHpaNDg4TFN3?=
 =?utf-8?B?MkRJOXluMENESS9QSktublE5L0VyNWQ4QTNoa1BLUDMyaVB0MmMyL1pHQzI0?=
 =?utf-8?B?TkpRSEh3MTBpS3lLZXJZRDRRMllxOVdXUmdpWjExUC94R1ZBVlROa3oxRTdu?=
 =?utf-8?B?UkFqRzROcGdBMTljYmZPV1JlRWVOTDRwZXVaaTJyWTR3WVhIMEpxNlJhbWZl?=
 =?utf-8?B?T0pjT0YyOGhvS2xXV1AramVPMWdnRG9qQ2tGMi82aE5vUDhqbTUwdElaYnpC?=
 =?utf-8?B?WEdONFo5OUpGYUVwcjd0VGd5eXNURHdJb1VQNXUzdDU3Q0JIMEthN25BYVVW?=
 =?utf-8?B?MURPaFZKQWFXLzFkeXdwbWJmR1FIMXhhUDJIVlFMcVdiLy9lR2hXd0FkSTlu?=
 =?utf-8?B?M2lQYU9pWUZPL2RMRmx5c1dSK2w0dXNhN011cm9tLzJza3kySms0RzJFTkRv?=
 =?utf-8?B?eFp4UzhSOVJ5K0Y4Y2YvVHRmNC83RHplWEErT0xMVkJpNjArTjd4LzF1dmpR?=
 =?utf-8?B?RGZiTkNUOUtmL09PdjBieXdQWk1mQ25NdlBDcXdZYU1RcHB6Q0NadzBDZWs3?=
 =?utf-8?B?TWZqVUlmS3pvUWpLZlNSZTBXemU5enFZRmR6Vjc3ay9zZk5MMWtQVDgxVzdW?=
 =?utf-8?B?NXFQakxaRjZLQkNXamVZcmtia2d6UFVsU3dpenpqaU4vdTdjbUlOc2pTVkt0?=
 =?utf-8?B?RDJDd3Q4SG91OTArWHdVcUVwQnNpK3lwY2NBYUtoVlhHN3VDNHowek9VUEJk?=
 =?utf-8?B?MldTeGgyRVFWOUdXSUsvL0s4WUxtbzlSNWZuTzkyK0V3UHROUE8wVUlLVnc5?=
 =?utf-8?B?QVRBRWJtZlVEbGtnZStSZjdsMFFzTStocEEzQUVTQU9kY1NLVzArTGh6Z0wv?=
 =?utf-8?B?M2N6dk1mT1JreVJWb0tBM1I2UEN0bTAwdGRrcEs0YmVXQkF2ak9QUTdoMW16?=
 =?utf-8?B?em9FUXJRUEoya3RXWXZLcGtFdTYxenRsWHlMQjAxcEhqZGtMSHFHa2MwRVls?=
 =?utf-8?B?d0tzRDFpbFdDQWVaSTR3Wi9JMUFCdVptNDV2N2Y0Ky9vZ0xIVnBwbnNwTjhq?=
 =?utf-8?B?TTc0bHI3aFkvM0Jwby80OERNd1VvcnZNUEpPZFJnYWFrOUpvaE9ZeWpGSU5S?=
 =?utf-8?B?elg0T250Y2k0WXNqdFZsR240RWpUMmtPQUhRQzdLbk9aWGFwMGNibE5DSHNW?=
 =?utf-8?B?U3lOc0F5bnB4ckRYcjhidGVHYkpBelEvNHJ4Nzc2VWVEQk1QaGVlWkcvV1cw?=
 =?utf-8?B?WHNPUG9xQ1ZJK0FhWHRLODJjN2Nzb3V6RytSc3UyU3pMMGkrY0xaR3RBMWxB?=
 =?utf-8?B?MEFsRTR4R1NkOXBkUzhVWWxXYStvcGZOWTlEaWNjUjN2cXcyWnA2aU03MUNk?=
 =?utf-8?B?NFBIYzdTV3g3NU1pV1pQZFdLR09vUzZlVXFLR0RrT1dKOXpRWW9YS0x4NVRO?=
 =?utf-8?B?MXJhdGpwaUJxSjZRNUxubDRkZE9iVXRqWXk2VVpRQTErTUp4VEpRQ1Q0ekNI?=
 =?utf-8?B?WUlBSXZYWm5SdDgxdlRPMTFBWWhsV3Y0cXVIdlo3RFJtMzlOZDNmbjltK29v?=
 =?utf-8?Q?AW9evrh/xpnLOIe8a43nB7vGM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd0c194-ce06-4572-0379-08dc02d99f18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 10:34:48.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPtAGu5UEVQgHSjQwNRe2Ip4vx9uWLlw1jETavtRqggwyuRBgYWBM0qL8jI2bf108d8tNcxodydLOFP2yg5tPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938

On 22/12/23 14:51, Vinod Koul wrote:
> On 22-12-23, 12:45, Mukunda,Vijendar wrote:
>> On 21/12/23 22:08, Vinod Koul wrote:
>>> so the code is copied from a GPL declared file to now and GPL + BSD one!
>>> Have you had lawyers look into this... why change one file license ?
>> As per recommendations from our legal team, we have updated the license as dual
>> one for amd_init.c file.
>> We have also observed that license terms should be updated for other files as
>> well (amd_manager.c, amd_manager.h & sdw_amd.h) as dual one, which we have
>> planned to submit as a supplement patch.
> Lets change that first before we move code from one license file to
> another
Will push the license update patch first.
>
> Btw why would you want to do the change of license form GPL to dual?
As this code being used by AMD SOF stack which uses dual license,
So we want to maintain the same license terms.
>


