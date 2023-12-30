Return-Path: <linux-kernel+bounces-13565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842D820824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E60283C88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B5BA33;
	Sat, 30 Dec 2023 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="pMJ6ggQa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB1BA34;
	Sat, 30 Dec 2023 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEqxMW3XTDLHB1QbgXDI7yStnhOOQhtlVlpJQ+HH9VD856Gs5jYz3bJKNVP4r3iCzYzjX5CbMJc2Khl1rN6ptjd7I2rt+xyefZdxcu4Qn6KfA3PZJGBxmytPELZJrkiYcb3s+MNjf3nIpFGlDIdpbupsLyjBQgAwQY+QfpVcDXzefzA2jMSbltw2l93EpDPh8sn4/rgoh7L337ho3a6sb79QWtSVbGeMGTp+HFiUSEg8UD9gRrmhgSrBjEifIpat/h+s1iANFrP5EtgMSu2fmVie/9Cg7LHzaPT/JFAwPBF9dOleN6m7LghegMViDOGzWbnK2CXHv56Xb0i8ZSPHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+hf1wiusJiuRI3TPytWqjDdlYbqZm07i/mGesq6OzU=;
 b=npXJVEOqFQf02BcXvcFB4+21xFaPsVQvz8lFmJeSRXRTYrCEdg1hghyLTbKmt7qGshHtAy4yDmofkB3ZgaW5h3JPBtrmP/RDsp2Sui2+nyxhlbLKR/6jtqGKl47cN7ORKp0eq+PzyfijggMeLIXiZyUqBaKGVwSdzrqob6dkK6Ga7X4r+AalG9si3x5Au2uLDi5gsHZaIXOM08cE0z/3cK5R9Y6dSaC3A3n5BBGp8K5FCKGIw+pn5EOdsYDWmv/2mtzCmkXhw7x7O801VrnnUv1Rg/I6fzC4CrQOId8gwrRzEOyvsDLV8de8zsHq3FXNKFGICfTo8d4y9onTE+xR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+hf1wiusJiuRI3TPytWqjDdlYbqZm07i/mGesq6OzU=;
 b=pMJ6ggQaab+4aYKjhLzgVueg4TNAL65UyZjddjUvU4u3ubGUps+uGYTs8w6J0DsuHnip9e0NI2YzoYyQ+4B9l7j4ETW8yCJCtdbN1ketc423qGRvYrUk4z2GdZ90Xk2TTmpTaB86XZXsz/AyWwDtUqxI80EZMA7vUqCFid3tFdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CYXPR08MB9393.namprd08.prod.outlook.com
 (2603:10b6:930:e1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.9; Sat, 30 Dec
 2023 18:10:32 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.006; Sat, 30 Dec 2023
 18:10:32 +0000
Date: Sat, 30 Dec 2023 12:10:29 -0600
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
Subject: Re: [PATCH v6 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Message-ID: <ZZBdFQhQ4k3hEHgz@nixie71>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-1-d8a605975153@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510-feature-ts_virtobj_patch-v6-1-d8a605975153@wolfvision.net>
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CYXPR08MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3c4e07-89ba-4237-7830-08dc09629cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UGqseQ6U/hnr8SZH2PuZeL8FGCBJYCMiPTemvQt96NPlcv+89O4JldxgvcIu3r6d7PXQ6u6R4l7W2xmoyzcYEPHZQvlvOc9Grf4c7a6VGXjBmhJ2HL5otJQp6yiBZMQ6p48qSId+6KMpAG5VJEyfbA4R9hrU/Riaz1W4iRMIB36BwLZBU3LZqL1eT+eC3puvtNXnPnaJtkbQFrevZlpXg4gEHTo8WBz2tXH2xjRhXvP4XbHn7cQFaksTbZH7K5lTVpF5g/t3AiLw3kwGqV4j4pyOw7jnU7OoW6guB5pYkIQKK47mG3A0niqKuktRWKA6qJQQ1np59ggyEykJqH0JnMrvJll/rporuEORQ2e3onTuYzKX4LfzJXpbyKSm7vlxeUmbPW88xwQ+ZIgEVqR+uzxjJj2XJlX/mlNBLiNqoerOkLnbH4VTZq4IRXEQeCU/bAEkBRWHHdVTliaKIyxdNMgK0wd9IZzrJOid6BOC1VFNENgg8R6YWAaXrN1MShxTfBXx9bydSIH9jbLQhpi0Oc59jxxWVhf6Tb5AM+bFYOqDnSfipqNJ4CuE8qJ8itk9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(136003)(366004)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(54906003)(66946007)(6916009)(66556008)(66476007)(38100700002)(6666004)(6486002)(4326008)(8676002)(8936002)(316002)(478600001)(6506007)(9686003)(6512007)(7416002)(5660300002)(86362001)(2906002)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNlZGpudkV1ZDJnSjRvZVAvOUdXUlZUWXpvclZ4RVlkTWdIS2x4NmxiSlFv?=
 =?utf-8?B?dDd0MHppNUhVV2tEelArR2cwdkMzcVk0QktPb2x3QzdxdzZJSnVBUG1PMXhM?=
 =?utf-8?B?bVM3NnJIbkgvVnBRL1k2UkNxOGxjSEZ0a2p0S25zdUV3QU0wY2NUY1dTbkpp?=
 =?utf-8?B?N09mekg1dE81L3EyNEdsTUtCZFB2LzFjc2xvVWRLOVQyMVNUWkRiZkZEUW1G?=
 =?utf-8?B?QitLY01ON0UwcEZmTkJQY1o2NmR4Z0tSdjI2eGRhUGMwY0s0S1ZRODJmNXll?=
 =?utf-8?B?WEg5T1pkUmZsalBuUGJCNVpGWGZ2RVFoVngrMzFlTTNyU1JjTVlUTk80QXFS?=
 =?utf-8?B?QXNqRkRiQWVzWnFJMHZOL2NheGJucGVsK0RZMHluUUE2OGExeGFSZFhlSFhl?=
 =?utf-8?B?ZHNTclBjdG84YzZTbGJ6RmV4SkxBbGJsWG41VWlsajFYRzlYc2wwMEtabXlK?=
 =?utf-8?B?VTdRS3F0MnFYZTU4QitLQ1lGRjNiZ3hodjZWUjFNeGVtOUhrb3AyTFFaNy9J?=
 =?utf-8?B?enh4cGo5aUJ3bHJlbkNORzArUGQ0SGl5QnZHVCtBNzdtckVLV3FETDRqOHBN?=
 =?utf-8?B?WVhzVG1VUVU2cmxrcGNwdXZrdjNrV01ZNTM0WDhnRUpnbmc4ZzRnemFjZjhu?=
 =?utf-8?B?bHJSZGdYUDZ6Ti9CdDFaUkJGWU1OMWRvSXE1Z3NxWkpkOVdHRDN5UEtDUEVq?=
 =?utf-8?B?c3ZmOTN1Ym45aFlxS1Vkb3FNZmpkQ1doVzlJQzQ5eUxyS0VBdEhQK3FIWGRD?=
 =?utf-8?B?eGZmMzdMRVVvV201SFVJZUJIUUh1a3B0MjlsYmR5Zmp1dUN0NWFZTkFaU2lJ?=
 =?utf-8?B?dVFSQmRRRTZ2OThuZ3B6Ry9KT0g0cmJHVzJZNEdkM295V3czMktKVHlDWmww?=
 =?utf-8?B?WlpsOWpqR1BTdE9hanBJYTRQUUsrZ1ovQjR2d0ViUytCS2ZKSTN4T3pkUVBO?=
 =?utf-8?B?RWI3L1c3MUVVd09lRDFBaE5qVjRobnUwc29vQlVlZWVtZWQydXhYcXg5dThI?=
 =?utf-8?B?QXNYZVNNRWlUeTh3Y1hkZGtxeHdHeVVuc09ESG1ncTBRQ2sweDFnMExqbG1U?=
 =?utf-8?B?N3V2dU1NS0tBVlUwNTFMQzdNb2ZqdG1BeVd3QVdHTCsvYW5VSjRSM1oraFRm?=
 =?utf-8?B?NXBGcjR0enlocSt2N3kwbTRiNTViOCtQejZaQ3IwS3p4eDFFOUovVytmNDdM?=
 =?utf-8?B?Rmk2Q1dYRWFzRUJtSjlLYUQzOTJlbk50RzhhUWFqbTE5T1NiS3c0Rk0rWU5m?=
 =?utf-8?B?ZHhmZmFHOFZOSTNHKzF0VGFjWFlGRVc0S05aUUFxbXN3MzVIbUVXOUlrMUVl?=
 =?utf-8?B?UEs2ZTlJWGd3cTlaUUpIcGZ6VUNwRkt1ZUdXZkRRSzRxTXVlNUpMaTRnK2hZ?=
 =?utf-8?B?czBzMDNSNHRhUENFQm1pejZFVEhXMjMzUG1GNGtLMUhUYllwZnJMNFFldDdv?=
 =?utf-8?B?Q3pHckQ3a3FSZFNpSzFmVTZHWXpXVnJFK0pmQ1g0am11bmZJMlVqMTFack0v?=
 =?utf-8?B?NmwraVk4RmhoSmxhWkcrUldLS2xiTTRvVlRCV3VCczBYc0RZZzVmclBGYWZS?=
 =?utf-8?B?cFlseEZld3lqZFZuZE01cDkvRGl2VkFiMFZ2V0VpZ2ttSVlWbWlFQU1DMXJ6?=
 =?utf-8?B?eWIyMGxiUUNkWmI1OHRLNUk2dVhkZmtzNFdrRUZKeW1rMkswem9Qdk5MNzRh?=
 =?utf-8?B?a0F6YlFaZHREaEppNEtBbDlHaUZ2UkhQQ2JWTnpGV0cvZ2E0TEMyeDZSeExm?=
 =?utf-8?B?RkZRQmJuaVhPZjhzOUlFcUwzYnR4Q25KamM0SEVGZS9HVDBxbkpja2F1UExQ?=
 =?utf-8?B?L1llcDdweGU3YUxqb1NlcEFpSU9tYnN2bHVBRVN6U29waVpDY2p1akdIQXB0?=
 =?utf-8?B?cE8ydW5ITlRPSnZWWjlsQmVJNWFCYjFLbDI0SGdBQzVvSVZoMGppTFp0UWsv?=
 =?utf-8?B?em9HNFh6OXA0RStxcG05YU9VZFQ0Z0pVbElQT0wxNHhMUGFpeWVBVXBaQzZT?=
 =?utf-8?B?QTM4ZnNtVXMzUjZJMkVYSGZWRnNBbzRXOWlDQjZsRFVkdUx0SEM0YlYyUGpL?=
 =?utf-8?B?N2E0ZG8zeVBEMGlJRUZlSW9IUDU1bldHRmR4REFpbCtldXZIQWl6VmhIeDF0?=
 =?utf-8?Q?hi943Ea8RE3c6pyvoGea9cqQ9?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3c4e07-89ba-4237-7830-08dc09629cb9
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 18:10:32.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 156PGLUPcHjKtmGdD1dgO7/J+NykbCpG96X1FLbxnAZM3Bl9JCysKxnhtJu/bZMAzfdd4qHje+q/OGak+SIkSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9393

Hi Javier,

This is excellent, just one small comment below.

On Wed, Dec 20, 2023 at 09:39:43AM +0100, Javier Carrasco wrote:
> The touch-overlay encompasses a number of touch areas that define a
> clipped touchscreen area and/or buttons with a specific functionality.
> 
> A clipped touchscreen area avoids getting events from regions that are
> physically hidden by overlay frames.
> 
> For touchscreens with printed overlay buttons, sub-nodes with a suitable
> key code can be defined to report key events instead of the original
> touch events.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index 431c13335c40..d5ac90667bef 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -87,6 +87,125 @@ properties:
>    touchscreen-y-plate-ohms:
>      description: Resistance of the Y-plate in Ohms
>  
> +  touch-overlay:
> +    description: list of nodes defining segments (touch areas) on the
> +      touchscreen.
> +
> +      This object can be used to describe a series of segments to
> +      restrict the region within touch events are reported or buttons
> +      with a specific functionality.
> +
> +      This is of special interest if the touchscreen is shipped with a physical
> +      overlay on top of it with a frame that hides some part of the original
> +      touchscreen area. Printed buttons on that overlay are also a typical
> +      use case.
> +
> +      A new touchscreen area is defined as a sub-node without a key code. If a
> +      key code is defined in the sub-node, it will be interpreted as a button.
> +
> +      The x-origin and y-origin properties of a touchscreen area define the
> +      offset of a new origin from where the touchscreen events are referenced.
> +      This offset is applied to the events accordingly. The x-size and y-size
> +      properties define the size of the touchscreen effective area.
> +
> +      The following example shows a new touchscreen area with the new origin
> +      (0',0') for the touch events generated by the device.
> +
> +                   Touchscreen (full area)
> +         ┌────────────────────────────────────────┐
> +         │    ┌───────────────────────────────┐   │
> +         │    │                               │   │
> +         │    ├ y-size                        │   │
> +         │    │                               │   │
> +         │    │       touchscreen area        │   │
> +         │    │         (no key code)         │   │
> +         │    │                               │   │
> +         │    │            x-size             │   │
> +         │   ┌└──────────────┴────────────────┘   │
> +         │(0',0')                                 │
> +        ┌└────────────────────────────────────────┘
> +      (0,0)
> +
> +     where (0',0') = (0+x-origin,0+y-origin)
> +
> +      Sub-nodes with key codes report the touch events on their surface as key
> +      events instead.
> +
> +      The following example shows a touchscreen with a single button on it.
> +
> +              Touchscreen (full area)
> +        ┌───────────────────────────────────┐
> +        │                                   │
> +        │                                   │
> +        │   ┌─────────┐                     │
> +        │   │button 0 │                     │
> +        │   │KEY_POWER│                     │
> +        │   └─────────┘                     │
> +        │                                   │
> +        │                                   │
> +       ┌└───────────────────────────────────┘
> +     (0,0)
> +
> +      Segments defining buttons and clipped toushcreen areas can be combined
> +      as shown in the following example.
> +      In that case only the events within the touchscreen area are reported
> +      as touch events. Events within the button areas report their associated
> +      key code. Any events outside the defined areas are ignored.
> +
> +                  Touchscreen (full area)
> +        ┌─────────┬──────────────────────────────┐
> +        │         │                              │
> +        │         │    ┌───────────────────────┐ │
> +        │ button 0│    │                       │ │
> +        │KEY_POWER│    │                       │ │
> +        │         │    │                       │ │
> +        ├─────────┤    │   touchscreen area    │ │
> +        │         │    │     (no key code)     │ │
> +        │         │    │                       │ │
> +        │ button 1│    │                       │ │
> +        │ KEY_INFO│   ┌└───────────────────────┘ │
> +        │         │(0',0')                       │
> +       ┌└─────────┴──────────────────────────────┘
> +     (0,0)
> +
> +    type: object
> +
> +    patternProperties:
> +      '^segment-':
> +        type: object
> +        description:
> +          Each segment is represented as a sub-node.
> +        properties:
> +          x-origin:
> +            description: horizontal origin of the node area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          y-origin:
> +            description: vertical origin of the node area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          x-size:
> +            description: horizontal resolution of the node area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          y-size:
> +            description: vertical resolution of the node area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          label:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description: descriptive name of the button

Please consider replacing the word "button" with "segment"; as we see in
patch [3/4], the label can describe a touch surface and not just a button.

> +
> +          linux,code: true
> +
> +        required:
> +          - x-origin
> +          - y-origin
> +          - x-size
> +          - y-size
> +
> +        unevaluatedProperties: false
> +
>  dependencies:
>    touchscreen-size-x: [ touchscreen-size-y ]
>    touchscreen-size-y: [ touchscreen-size-x ]
> 
> -- 
> 2.39.2
> 
> 

With that changed, feel free to add: 

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Obviously we need Dmitry and the binding maintainers to review as well; I am
merely expressing my own agreement as a future customer of this function.

Kind regards,
Jeff LaBundy

