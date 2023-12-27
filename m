Return-Path: <linux-kernel+bounces-12254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36F81F201
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8301C20A60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79633481A3;
	Wed, 27 Dec 2023 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="VysMLFp1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857D481A4;
	Wed, 27 Dec 2023 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoSwVOmHNwTH1B8tBFn4yMPq0DiS0k01WkJDnA+bW9X6FmoJ1jtfYrKGXMzclI/bvC3nEm4ngcvSFIfBMh6vFrlHKJa2Cf+jFdp0PY8mEh2s8B7IjZZEarpRlZFQ8D9zZ33o38Tb6TGjGjVYsNet0qJSzw1WP9uO+SV42srTnciZftO8kxRk5klpiU4tNrmGfJfLJPhTDWTJeWAHW4H3aRZY8x0BrEPkIJZHpNJGzCW6xB8yO9UQXbnIrR/A2BB+ClBTU8qNkPrLyGk4D/fKdzpwWyyO6QMbwLbcX1JegNaXTuvD8MtyKibpHxSpEcnoHAa9HsqLkfVY4KNIQsn/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itz+W7Yok0o6vZuofEM8ukXyJ78BNo5WEwXHZCmDN64=;
 b=LGBV0kZvBPxiHDA4HzOAtWKHXEV920cxepR2WVar6KQGdx5jtiecHAw2xhvK2mPP3gsbmhxa9doHCg6a445NOpCmauU/xI15njlrg3WVwSvCMDpOV2hNGEl0wmEUXjA54gHRWEbDH8LQ8ol811+Id4uiGIGHzwoGSceXmduVwPDhr41eZm5NA2tWpnMcObyZZLTm0NORGzWgcXh0eV2gqOA+CBVDpqM4v4G2xwZgU+v995WD9GcW8jBKDDOXN1vLYiuuoqpx5wNZ6D3yG2JH4WVuXdoH18x7/8ub1uuweuyQTkPOJpmBWx3TSRNEl+JvVpXdNTHhOAte5ajKi7aUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itz+W7Yok0o6vZuofEM8ukXyJ78BNo5WEwXHZCmDN64=;
 b=VysMLFp1LKmsDQPniGNSveEQqhMPPpFc8kC9PkzN7dvmjJzZNx5JaqtXo/BNw66XXjSfti11ZXtatuzpcY+qNWMQoGuUxa6LZQ4j/xdLWzMu/wTdFQvraSgQVquYV7VZE70z7gX73l6n6FU1F3U5y+wMEeyYdtj4PUh8WS+1PQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7256.namprd08.prod.outlook.com
 (2603:10b6:303:f2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Wed, 27 Dec
 2023 20:53:49 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.006; Wed, 27 Dec 2023
 20:53:49 +0000
Date: Wed, 27 Dec 2023 14:53:43 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bastian Hecht <hechtb@gmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Message-ID: <ZYyO1/kKGL3C9QAF@nixie71>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
 <ZTp72LUXxr+Z9gn8@nixie71>
 <487555fa-72ad-4d1a-ac68-51826f56f1cd@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <487555fa-72ad-4d1a-ac68-51826f56f1cd@wolfvision.net>
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 469588da-23f0-473f-cfea-08dc071ded16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/97aaVQvIP94oU4wgUGowgC8e4YQWo0BCq4f9ZPWb23hPTmWrc6EbYQmmUasdBsnO9/LtRaqXfJmLHnXFlomU7rJ3e+FdP8i8nffpBTpHTXgAsNVNhyG5XZr7xvgASfED3CGgOD8i4+0dq3SoYwVHfRMqT8bz9TyN56nDkwOMIFI450AN7aa4RM0RilHCKEVTMxF4ppdiOxn4dRz5x+2nfaJhzIFGUMTu5BT8cDEiPwkyigmttk/Yn3GxPrL9eQdo3UrqpfOTnfOAIUNxtUYa7k6H41rPKleOT7HQo2JnDTzVuNkLwqJZEfiix8X+uI3cl2KzrYsMkcTNeA7TDWsMW+mcy60SrSJEIh0rFzHnyfYBXZN32+N+jjhMCeCpVHcvXJigabPZoymA1Y0xHii6VcfBdmxRE5s+cjaPygJODji0eeL2Wal1EvOohTrxL2Aq0AXQDtgB9cuHDlk+pCu4Rg3sDU9Z70u1rZnXq4SbIqvINsb70Rsnqjg4DuAcSlKejiG5WdIMnQfyoYEP6vMTEsZyRCrfHikv2RwQd8ljgwDz2ufXsncJ5N5ycYrY4wi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(346002)(376002)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(9686003)(6512007)(26005)(33716001)(66946007)(8676002)(4326008)(6916009)(66556008)(316002)(54906003)(66476007)(83380400001)(478600001)(6666004)(6506007)(53546011)(38100700002)(86362001)(8936002)(6486002)(5660300002)(7416002)(2906002)(30864003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNYZ1BVSC9QQ1JLOERzMXh5V1RtOUVwaXNFS1E4dE5OT05pWlhrdkplMU5N?=
 =?utf-8?B?ZXVyTEsrMmYxaFE0Q1VPeTVRRU1ZaHk0NG9uTXhvYm1hMU1XM0lwUHBoV2xG?=
 =?utf-8?B?cnlONFFueC9lYUVEMnBQTWdXbWF0M2Vpa21jM05LZUNrSk1rS3ZySzR1N2Zv?=
 =?utf-8?B?TTRMOTFQYWZwUjZVTTV4SUFkUU85SlJoaUMrSWRadjgreE1MbVJJZ0F5VW45?=
 =?utf-8?B?Z2pCckgyRXFiK3NyYm1UODRTL3Jsd2YrRTU5TG1IRzBDd3paS2pwamVvZkVG?=
 =?utf-8?B?L2xGaENGQnJXTHowRzFOZ1Q1Q2w2NU4xZEMrMDFrckd2NkYzblU3STN6VGcv?=
 =?utf-8?B?VTZURDRqNEJXTkdZNHA2NU5uUmR4dXN1bkthbUVwMGd5bFRyNFJIWlhqdHVh?=
 =?utf-8?B?ZVlRUUhVZUExM291SHBYZHhUVXRpalhpanJNVnJDVFpBckdDTWwrYUxQVkox?=
 =?utf-8?B?N1Q3VkxDbExtQ3k5OWNmMjFsNE9tVUZjTk4rcGJqdlRHK2ZhaHZRUEdOV3hZ?=
 =?utf-8?B?aUN3NnZUNkc5cldDR0k1NTE5UGhlcWN4R241NnJvRGZGbFFNTDN6U3I3Vjhk?=
 =?utf-8?B?MEV0alNPeVJjbFZwWlhLeS80NVZraGtDR21pZ09QdmZCMnJpa2k1ZC8zY3N5?=
 =?utf-8?B?M2MrY3BEelhiNzZUVXpsbm9rT3R4VGNyUDFIWGdwVkJ6ZitFK3F6VnREdkY2?=
 =?utf-8?B?OGpPdmpJdjJ6aERtejUyaGkzM3U2UVNYcTg3eHJ6dXhXc3ZNSUVvTVNFY0Y4?=
 =?utf-8?B?Ym1XSFd5ZWRUYjlQUDFuVVB5M0RmaXg0VjZkaGUvc2lQc3MyMkJUdTVyMGxD?=
 =?utf-8?B?Z09wZmVxS0htSUxHdFNyS01nWHprSHBzZ09YWWxqMGxmaHBQczlPeWVoaWZR?=
 =?utf-8?B?aFNhSlg4NTFGcDQ1RHRCSGJtN0VpL3BRUFp6Tmc2TDNrQnZ1ejd3VmNqcTM4?=
 =?utf-8?B?SlRDY1l1elFOenFMTGovT2g2S0FGY2xVVVcwSGRJSGNZRDFJa1ppSHRSTStn?=
 =?utf-8?B?ekZXZFdxMGdpWldPa0JMZHU1a0ZUTDUyMDlzQ1paWThrRDk4eU82OTU3K0pw?=
 =?utf-8?B?d09kdzJJd1pKYVhhaVFpZU44MU9vTnd3dXpLN3FpRnBrUGJGUWdIeWdxR3BC?=
 =?utf-8?B?KzRDT3pIM2dCM3lucGVzVUhxRCtBT0FZd0dvelY4dW5BR2lOdlloQjJZalJK?=
 =?utf-8?B?WjlXcDI3dW1Ua3RRK0JJWEV5MmZWMlJwZnFCOUZUb1QzNkppSkVXeGp5WTZt?=
 =?utf-8?B?QytYR3h0SnluTHpjZUVyNlN6OW8yc2l5Szh3dldybEtKVkcvVjl3TnR2ZE4v?=
 =?utf-8?B?R01Lc0FVRXpPeTdyNzc1eU9WeTBPbWRYaUJRNTRJOE5NWjRycUR3MDlTM24v?=
 =?utf-8?B?QXpaUG5BVk80N3RsSnE4RkZMTHRiWlNOazhxaVBtekNheE9Eamk2TFRqUUxX?=
 =?utf-8?B?Qy9DeHVtQ1VOUlNwUEZFUXpoeHJ2WWZ5LzJ5U1h6Snhoa0FQd1JnLy9xQmk3?=
 =?utf-8?B?S2dZTTNwRlY0Q2kvdExjbEtDVkdoSHlZd29SQkoyV2pUanl2aEFLQUFlSHQy?=
 =?utf-8?B?V1dZbFFNVGNlRkdmQUlMSU13SWJhdmFNak5rTVFFeWVSQnBJR1A5K01nUDh0?=
 =?utf-8?B?YnN5aEZnY2pCNlgvdno5ZW04THdkT3dmVWlMWENFMjlVcG9iRWFGNXdvZlFN?=
 =?utf-8?B?cnlTUUx3RTM2ekZBcXNGR3VhVS9vVzl4NzN3bUMxNVQ5VndtdkV4NjcvaUFh?=
 =?utf-8?B?elJWSmR3UEdMVFZkVlJFMGhCZDEyWnh6cTQwSmdvaUZTVzBDek90VzFacm01?=
 =?utf-8?B?cFpIUWpvNzRtMSswVmdzL3VNYjBjUXZCTGl1K0FLVDV1aXl1VjdCM3JKYTVh?=
 =?utf-8?B?LzhuZWJOcXhWcS9UVWkzendmS2xzUFl6eFVlVmVGZlRHSlZmTEw2WVYxajFR?=
 =?utf-8?B?TXQxa2swVDAvU1A0NmxibnRndjF0RndjbW1nVnlmU3gvTFp2RStBamdtaHhm?=
 =?utf-8?B?dmpYMHUxVVlpRThLOUthbjJwM0xFREhhWlFKeE5NN24waEFpOVZDUGp5NFU2?=
 =?utf-8?B?eG9VM3IxclI4cSs2dzIybjNzRnZpdktINFBlekd3UUllRmJtcWROS1RYeHpl?=
 =?utf-8?Q?QDfzvUpVGBkCNvcDg6UejZUer?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469588da-23f0-473f-cfea-08dc071ded16
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 20:53:49.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzU0tP2UbtyihW0qA0i/J9fvvCh9TfpH5WjDWbyiZ5I3NPWs5+ZTZKozH8RCnxYH3MoJ4R81N4nX7Nt70itXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7256

Hi Javier,

I am so sorry for the delayed response.

On Thu, Nov 23, 2023 at 08:48:56PM +0100, Javier Carrasco wrote:
> Hi Jeff,
> 
> On 26.10.23 16:46, Jeff LaBundy wrote:
> > Hi Javier,
> > 
> > Thank you for continuing to drive this high-quality work.
> > 
> > On Tue, Oct 17, 2023 at 01:00:08PM +0200, Javier Carrasco wrote:
> >> The overlay-touchscreen object defines an area within the touchscreen
> >> where touch events are reported and their coordinates get converted to
> >> the overlay origin. This object avoids getting events from areas that
> >> are physically hidden by overlay frames.
> >>
> >> For touchscreens where overlay buttons on the touchscreen surface are
> >> provided, the overlay-buttons object contains a node for every button
> >> and the key event that should be reported when pressed.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> >> ---
> >>  .../bindings/input/touchscreen/touchscreen.yaml    | 143 +++++++++++++++++++++
> >>  1 file changed, 143 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> >> index 431c13335c40..5c58eb79ee9a 100644
> >> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> >> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> >> @@ -87,6 +87,129 @@ properties:
> >>    touchscreen-y-plate-ohms:
> >>      description: Resistance of the Y-plate in Ohms
> >>  
> >> +  overlay-touchscreen:
> >> +    description: Clipped touchscreen area
> >> +
> >> +      This object can be used to describe a frame that restricts the area
> >> +      within touch events are reported, ignoring the events that occur outside
> >> +      this area. This is of special interest if the touchscreen is shipped
> >> +      with a physical overlay on top of it with a frame that hides some part
> >> +      of the original touchscreen area.
> >> +
> >> +      The x-origin and y-origin properties of this object define the offset of
> >> +      a new origin from where the touchscreen events are referenced.
> >> +      This offset is applied to the events accordingly. The x-size and y-size
> >> +      properties define the size of the overlay-touchscreen (effective area).
> >> +
> >> +      The following example shows the new touchscreen area and the new origin
> >> +      (0',0') for the touch events generated by the device.
> >> +
> >> +                   Touchscreen (full area)
> >> +         ┌────────────────────────────────────────┐
> >> +         │    ┌───────────────────────────────┐   │
> >> +         │    │                               │   │
> >> +         │    ├ y-size                        │   │
> >> +         │    │                               │   │
> >> +         │    │      overlay-touchscreen      │   │
> >> +         │    │                               │   │
> >> +         │    │                               │   │
> >> +         │    │            x-size             │   │
> >> +         │   ┌└──────────────┴────────────────┘   │
> >> +         │(0',0')                                 │
> >> +        ┌└────────────────────────────────────────┘
> >> +      (0,0)
> >> +
> >> +     where (0',0') = (0+x-origin,0+y-origin)
> >> +
> >> +    type: object
> >> +    $ref: '#/$defs/overlay-node'
> >> +    unevaluatedProperties: false
> >> +
> >> +    required:
> >> +      - x-origin
> >> +      - y-origin
> >> +      - x-size
> >> +      - y-size
> >> +
> >> +  overlay-buttons:
> >> +    description: list of nodes defining the buttons on the touchscreen
> >> +
> >> +      This object can be used to describe buttons on the touchscreen area,
> >> +      reporting the touch events on their surface as key events instead of
> >> +      the original touch events.
> >> +
> >> +      This is of special interest if the touchscreen is shipped with a
> >> +      physical overlay on top of it where a number of buttons with some
> >> +      predefined functionality are printed. In that case a specific behavior
> >> +      is expected from those buttons instead of raw touch events.
> >> +
> >> +      The overlay-buttons properties define a per-button area as well as an
> >> +      origin relative to the real touchscreen origin. Touch events within the
> >> +      button area are reported as the key event defined in the linux,code
> >> +      property. Given that the key events do not provide coordinates, the
> >> +      button origin is only used to place the button area on the touchscreen
> >> +      surface. Any event outside the overlay-buttons object is reported as a
> >> +      touch event with no coordinate transformation.
> >> +
> >> +      The following example shows a touchscreen with a single button on it
> >> +
> >> +              Touchscreen (full area)
> >> +        ┌───────────────────────────────────┐
> >> +        │                                   │
> >> +        │                                   │
> >> +        │   ┌─────────┐                     │
> >> +        │   │button 0 │                     │
> >> +        │   │KEY_POWER│                     │
> >> +        │   └─────────┘                     │
> >> +        │                                   │
> >> +        │                                   │
> >> +       ┌└───────────────────────────────────┘
> >> +     (0,0)
> >> +
> >> +      The overlay-buttons object can  be combined with the overlay-touchscreen
> >> +      object as shown in the following example. In that case only the events
> >> +      within the overlay-touchscreen object are reported as touch events.
> >> +
> >> +                  Touchscreen (full area)
> >> +        ┌─────────┬──────────────────────────────┐
> >> +        │         │                              │
> >> +        │         │    ┌───────────────────────┐ │
> >> +        │ button 0│    │                       │ │
> >> +        │KEY_POWER│    │                       │ │
> >> +        │         │    │                       │ │
> >> +        ├─────────┤    │  overlay-touchscreen  │ │
> >> +        │         │    │                       │ │
> >> +        │         │    │                       │ │
> >> +        │ button 1│    │                       │ │
> >> +        │ KEY_INFO│   ┌└───────────────────────┘ │
> >> +        │         │(0',0')                       │
> >> +       ┌└─────────┴──────────────────────────────┘
> >> +     (0,0)
> >> +
> >> +    type: object
> > 
> > I am still confused why the buttons need to live under an 'overlay-buttons'
> > parent node, which seems like an imaginary boundary. In my view, the touch
> > surface comprises the following types of rectangular areas:
> > 
> > 1. A touchscreen, wherein granular coordinates and pressure are reported.
> > 2. A momentary button, wherein pressure is quantized into a binary value
> >    (press or release), and coordinates are ignored.
> > 
> > Any contact that falls outside of (1) and (2) is presumed to be part of a
> > border or matting, and is hence ignored.
> > 
> > Areas (1) and (2) exist in the same "plane", so why can they not reside
> > under the same parent node? The following seems much more representative
> > of the actual hardware we intend to describe in the device tree:
> > 
> > 	touchscreen {
> > 		compatible = "...";
> > 		reg = <...>;
> > 
> > 		/* raw coordinates reported here */
> > 		touch-area-1 {
> > 			x-origin = <...>;
> > 			y-origin = <...>;
> > 			x-size = <...>;
> > 			y-size = <...>;
> > 		};
> > 
> > 		/* a button */
> > 		touch-area-2a {
> > 			x-origin = <...>;
> > 			y-origin = <...>;
> > 			x-size = <...>;
> > 			y-size = <...>;
> > 			linux,code = <KEY_POWER>;
> > 		};
> > 
> > 		/* another button */
> > 		touch-area-2b {
> > 			x-origin = <...>;
> > 			y-origin = <...>;
> > 			x-size = <...>;
> > 			y-size = <...>;
> > 			linux,code = <KEY_INFO>;
> > 		};
> > 	};
> > 
> Now that I am working on the approach you suggested, I see that some
> things can get slightly more complicated. I still think that it is worth
> a try, but I would like to discuss a couple of points.
> 
> The node parsing is not that simple anymore because the touch-area nodes
> are only surrounded by the touchscreen node. Theoretically they could be
> even be defined with other properties in between. The current approach
> only needs to find the overlay-buttons parent and iterate over all the
> inner nodes(simply by calling device_get_named_child_node() and
> fwnode_for_each_child_node() the parsing is achieved in two lines +
> error checking). So maybe even if we opt for the single-object approach,
> an overlay node to group all the touch-areas could simplify the parsing.
> Or did you have a different approach in mind? Your example would turn
> into this one:
> 
> 	touchscreen {
> 		compatible = "...";
> 		reg = <...>;
> 
> 		touch-overlay {
> 			/* raw coordinates reported here */
> 			touch-area-1 {
> 				x-origin = <...>;
> 				y-origin = <...>;
> 				x-size = <...>;
> 				y-size = <...>;
> 			};
> 
> 			/* a button */
> 			touch-area-2a {
> 				x-origin = <...>;
> 				y-origin = <...>;
> 				x-size = <...>;
> 				y-size = <...>;
> 				linux,code = <KEY_POWER>;
> 			};
> 
> 			/* another button */
> 			touch-area-2b {
> 				x-origin = <...>;
> 				y-origin = <...>;
> 				x-size = <...>;
> 				y-size = <...>;
> 				linux,code = <KEY_INFO>;
> 			};
> 		};
> 	};
> In my opinion it looks cleaner as well because you are defining a
> physical object: the overlay.

I like this idea. My original example assumes one would include any node
that contains some magic substring (e.g. "touch") in the node name, but
thinking about this more, that may be a bit presumptive. It seems safer
to wrap all of the children in one newly introduced node as you have done
here.

> 
> > With this method, the driver merely stores a list head. The parsing code
> > then walks the client device node; for each touch* child encountered, it
> > allocates memory for a structure of five members, and adds it to the list.
> > 
> The button objects do not only store the keycode, but also the slot and
> if they are pressed or not. I could allocate memory for these members as
> well, but maybe an additional struct with the button-specific members
> set to NULL for the touch areas with keycode = KEY_RESERVED would make
> sense. I don't know if that's adding too much overhead for two members
> though.

It's still not clear to me why your code is responsible for storing button
state; that's the job of the input subsystem. Your code is only responsible
for reporting instantaneous state after you are told something interesting
happened (e.g. interrupt). The input core is responsible for determining
whether the most recently reported state is different than the last.

> 
> > The event handling code then simply iterates through the list and checks
> > if the coordinates reported by the hardware fall within each rectangle. If
> > so, and the keycode in the list element is equal to KEY_RESERVED (zero),
> > we assume the rectangle is of type (1); the coordinates are passed to
> > touchscreen_report_pos() and the pressure is reported as well.
> 
> There is another case to consider that might make the iteration less
> optimal, but I don't think it will be critical.
> 
> A button could be defined inside an overlay-touchscreen (no keycode)
> area. Given that the other way round (a touchscreen inside a button)
> does not make much sense, the buttons have a higher priority.
> 
> Let's take your example: imagine that your third area
> is a button inside the first one. We have to iterate through the whole
> list until we are sure we checked if there are buttons in the given
> position, but keeping in mind that the first object already has the
> right coordinates to handle the touch event. Your approach even allows
> for multiple no-key areas and we do not know if there are buttons when
> we iterate (there could be none).
> Therefore some iterations could be unnecessary, but this is probably an
> edge case that would cost at most a couple of extra iterations compared
> to a two-list approach.

I think we need to model the overlay as having only two dimensions, with
nothing "on top of" or "inside" anything else. For this case of a button
inside a touch surface, with the latter making a square doughnut shape of
sorts, the 'touch-overlay' node would have five children: two tall
rectangles (left and right), two shorter rectanges (above and below the
button), and then finally a button in the center.

Stated another way, the 'touch-overlay' node shall support an infinite
number of infinitesimally small rectangles which comprise the entire touch
surface. It shall be possible for a contact to be in zero rectangles, but
impossible for any contact to be in more than one rectangle. I appreciate
that the devil is in the details, but here we are defining the interface,
independent of the implementation.

> 
> I will keep on working on the next version with a single list while we
> clarify these points, so maybe we can save an iteration.

I see there is a v6 now; I'll take a look at that next. Thanks again for
the productive discussion!

> > Kind regards,
> > Jeff LaBundy
> 
> Best regards,
> Javier Carrasco

Kind regards,
Jeff LaBundy

