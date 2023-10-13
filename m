Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB827C8294
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjJMJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJMJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:54:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A9DC;
        Fri, 13 Oct 2023 02:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXemllKhyHykeMibhBG5hLOlY3Qa1/5XGF/Ef3oSJt+L9+s0SjKabwdHsIObKAqAKaGfmAeVqPrIzuL37C83Oiv72XPW+GbpcOK7Db4MkzhGc0aShjfCfazY4bZVXb7MHBVuXcn1eTyptbxOZpJtAnC/94fPsW/CSmLLYyD0ScT9o4dHmNIswtwY5TfanTt07eGdnjFRrzj3sG7HmRRkDyISqdXdA/cL2LRlpNRRGlSdlYRi75YqRVkn6YZ8xGvUEIkxwVX1L4BhKa+5kN6RaccfRnFksoHcDCW68U5OuQSbtS7RoFS7vsoWuyV0hMwWSUt0UV5DqVMegWyl64S0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6HAf8yRJTkZvaFcG1Jl/uiCXVE+YKygxWASEC1Rspo=;
 b=VzJvk8YSeC8lKmgciCvcSFSINwSz+Zil1mP8utwGKUtIwafVfUyM29NPHn3bKywtbjMmi1V5fY3PaHT9/yQOVPj29BnFS8OiXXmy27cf9orBWmMdnulQQmbyvCDxqqJ5A3cX+2kp984zHLxejGmeyey1HiR24OX8HEKdxwiCGQ3kKFSYuEPXakwydKPzUdoM/mX48URf8HTfC1B1mYDehnSPHKnQov5amxAAcV74oJhfxe1IZnf6szal4bHBhcG0fBFNrR1kGpiHuJTGc6EmbhXANeo/pM/8snvPTKifUwQYOjUHGxzVDDwCksS5CwgTEDZ2DJgcSCXmc/KyQwLCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6HAf8yRJTkZvaFcG1Jl/uiCXVE+YKygxWASEC1Rspo=;
 b=vxE6Nr1JydbWJ00aAqYKT/fB23SM+fHClPi8Fe+S/yo0D8FimGX3tuTyX9RY/MKYKx4Y5ABLdyOVRUetjkh8jld8pMe4UjRnBGMj+ZIe0XMbqjqS59PE4A9QvlTpwTrI2L7D8cqxTsLLSu04ttWP39EfBVEx4kgXlep8Way8Wx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Fri, 13 Oct
 2023 09:54:39 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:54:38 +0000
Message-ID: <811dfdb3-d5e0-443d-b7ac-6f7ef7ce22ea@wolfvision.net>
Date:   Fri, 13 Oct 2023 11:54:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v4-2-5c6c0fc1eed6@wolfvision.net>
 <20230831114827.GA1941458-robh@kernel.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20230831114827.GA1941458-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: b20a4727-593c-4a84-c6e1-08dbcbd269bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsfYlSkIjVapsn+pwduFYkNXHvzclQ9RjMXZOE7y6jmbiTYm75E4mAsgcVq0EspQgiTcIllmK8gW6Ezs6YFwE7eO3DatcGQKP+WAXIJjqSSNWbYpgFubS0rNeGNJZ9EbE1gVL0BWp+Y7+gyD+B7/xK0cpnWqOJ+XnmVv5jLBNVwU+H39jwmHzzt1nMdYNE+RtPtXeIiXqAO1+oH9r8ARk9O9EgVIquL1Ehn1qQs8aYgu3w/enKEYf6GFsoEI3EjYjFp37WNbv6rG9zD50OQieUZukUcjJz/C2+NchSvCXQQlD4hTjNyDJ3L+ENVFHhDHgYFN4eSxhPmC6ZPrryPb/AovzVYCKfELBxtX2HGdI2eHsBjtmWiGi32mvcjzsgguramH4XZ+pPsR9LfBDrD5Uw3ujjMrG3I/8+41kiWZXbkQnSSuE7T8RcXd8VNOfPljCMHKLd7R2nIZP1PRSJrb+7V7H5ZXpLnq0zwlM7gBMDItH9xPa4m8Mg2r1utjfC8mvGZXTY0Yw43Z6nCtCb/5jwZxIO5uZjhFX5GQRNpdx5JmCIufZmnzw+noc0ROEjS/xttXO7RJTo6Au7Fldo8TWlyNg7z3FgS7Y9Oj1NIoM6XTTHYx/bH6mYSPdM3OD5rDn8ZBKnlr1vjS6SurLKlDJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(86362001)(44832011)(6916009)(53546011)(66556008)(6506007)(54906003)(41300700001)(66946007)(36756003)(26005)(2616005)(5660300002)(31686004)(66476007)(38100700002)(316002)(6666004)(4326008)(8936002)(8676002)(478600001)(31696002)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXk4a0QrdHlrOXRXM0RWdG5YWFFpdkFmaXA0dXI1R3VONVdWSG5uUWFBdVJ2?=
 =?utf-8?B?N001Ri9GVnltNFVnUzVXZXZQa24rZEhIUUhFam04S01NS0pqbGNzVWhrc28w?=
 =?utf-8?B?V2pvUTkzWjdFam9zVzFWV1dwdnFsdkNVZncwakx6YzZkbGZuQ0Vid3Y2b2xT?=
 =?utf-8?B?V0VBRUZaNFdGZHd5aGtaaHMzdkpFaDIwNURRa2w0dHdLelhSUE0yaEZKQXNU?=
 =?utf-8?B?aFQxRnRRZHdlRGlSQUdxcjVGMUN5MDBtbzJkRHNoMGFKTmlOTjYwRUQvazdQ?=
 =?utf-8?B?K0Zsc2NhZFhZNEdlR0xrd3d1REc5b084WWswa0laZUpidmpUWkZGOFRGL1cv?=
 =?utf-8?B?Qjh1NjhYdEVOQjFkMUdJTWc2T3Uzb0VRZ09xRWh6RlZET2xoS1AwU0dsczFn?=
 =?utf-8?B?Vk50ajV4cXlTK3VQQ3c3b0J0RWw4VVVCS1pMSzlTMlZ5bFlCV0Rmc1g1Vklr?=
 =?utf-8?B?dFd4QXMrZVBDbXFVeDAyZ1V4RXRXaFlLNXFpL00weEFmMnpKKytGWGZtRGE0?=
 =?utf-8?B?eEdYY0F5b3JQQmJlb29WZ2JyUHJVVFUzUGl2R2I4Y3FuTWx2d0JtTy9vSXFM?=
 =?utf-8?B?ZjljcU56dGlnZDJjVTFqb04yUmFTcFZTald0WUxnMDk5cXpQUkYrcVJEOFhB?=
 =?utf-8?B?bzZlNVloYjVQeG5CcjVDTWpBRXg2bVJ3SVp4OE1jbUFZT3UrWm40ZUh1bTJz?=
 =?utf-8?B?bEN3VVVLUjllNjVmWW42Z0xZenl1WkViOTVTcTk5UDdxbVhwRUw5a2ZQWXBk?=
 =?utf-8?B?T0RTaUhMUURqNU1DWGxkeHVMdmJTWjRUVFBlMUpuQkdicm5rOSt3Y3NjOHlI?=
 =?utf-8?B?VkZuTzgrd3lTMnFyMEtXb3Y1eEdEZjFZSkwxSTVaYkU0QXh3em1sb2RkaURz?=
 =?utf-8?B?ZG5Zb2NWVHdHcWpUV0ZvdHVKbUE3Sk1PNEVMeEZKbkxjSzhLb2lPeFhEY2tI?=
 =?utf-8?B?OWU2QUZsaFNGc2JrUlFFbEM5ZkNjaENJZ2hCOTZHR0twaXVXWkhGcjlIVVdu?=
 =?utf-8?B?WFB2SUhNRDc1Yy9CUEJ0WFgxcW1XeEdXVFlrNHcyQ1BMNWd0WkNmeTkvMmRG?=
 =?utf-8?B?dS9tejMxWHBDSWtHTGViTXN6MVFFVHpqOTA2c2J1RWQxWVZ6cHRGMGVUUWVX?=
 =?utf-8?B?OGRVa2lTNm8yMzR4WGNzT0RrWSsyL2N0anBuQkpNTkNLWmw3K0didE1NLzJU?=
 =?utf-8?B?ejhVbnVrSTJDOUdOQnRBYTFYNXlybUpGU0o1bkFsRXpUa0xDMTFjcTlHOFB1?=
 =?utf-8?B?TjZSRGw3TU5NYUVldnNKU2s2NjYvdnFSSGtFUzZLbG1wSWNCOE5pSlUyL3NL?=
 =?utf-8?B?dXJ1ZTFXanE2V0NEMlRVWnAwZnJTMGxIU21QcElwZ09FaXFWUCtaUlZKcGpt?=
 =?utf-8?B?R3poOFpwQkxQMWVLZmFlZDRscE1xaTRBUGlSaVVxVWZVODNxdXl1T2JkNXFQ?=
 =?utf-8?B?M2pYQ3d6WUFDWW9aSWo5VE1DazlGd2tnNlJqVDBMQi9vMHRiMjgxOWlsd2hX?=
 =?utf-8?B?SVp5T0ttVXVhM3JBYWhuZzBDb3c1Rzdpc2w1blEwcUZnRHZpenY5TG1laG5z?=
 =?utf-8?B?VzYwQTRhRFdmd2FHVnFqMVdmRUpBUnlRWmJYSU9EWmxPSXA5M0t3SXQvT1M5?=
 =?utf-8?B?RGJtYlJDL2orSnh5MytMN2lYOGJjbHVrQ1hNb0RybkErM0s3eTFuT0I5YlRz?=
 =?utf-8?B?SUdBSWwvaE80bmNqQld2US96Z1dhajNuQnpxUXFJUyszc0kwRUNRS3BQS2pu?=
 =?utf-8?B?NHB4Y1JmOXlWNWxFOVNrSlMxVjl6N040ZDJUd1hSaTdUaGNiUUlxbXk3QUla?=
 =?utf-8?B?d0NBVmdKVXZXSGRXY2lMZDZrTHJHYllSSlFBbXdiSzVSSXJ1N0dlSkNSV1J5?=
 =?utf-8?B?UlJqbTV1cDY5NHpUbUpReW9TWmFIQjhZNm9xMVROeHNmVEVia0VBYXFvOWpD?=
 =?utf-8?B?T3J6MTZHRTAvK1g2K242bENnREovSXNrYmorM3JGMGc4a2ZVMFhSQURvM2hu?=
 =?utf-8?B?enR5V0VTNk9VWk9QZVRIRUhnbE8zK0ljUW1YeURPM0RlKzcxRjMzZTNiUHpJ?=
 =?utf-8?B?WTVyVkFmWE0xMWx2L21Ja1BPUWw2QllkZEZPckJvUnkveWdaaU1nVFlBRjRu?=
 =?utf-8?B?bjE5anhWQ2p3cVd4SGVONzZzWjNVc3NLNE51dWdqVnRpVGY4alY0UXg2TStp?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b20a4727-593c-4a84-c6e1-08dbcbd269bf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:54:38.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMN5GlxleFZpg7eLTB4M8TUi/2oTYipjRrvV5zq7QalwPfegSHr3JhrQo0p/MM0CC/hnyTPfuNrfsJuytl76RM6F5a2XF0OppmmOvEwzrp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 31.08.23 13:48, Rob Herring wrote:
> On Thu, Aug 24, 2023 at 03:17:10PM +0200, Javier Carrasco wrote:
>> The overlay-touchscreen object defines an area within the touchscreen
>> where touch events are reported and their coordinates get converted to
>> the overlay origin. This object avoids getting events from areas that
>> are physically hidden by overlay frames.
>>
>> For touchscreens where overlay buttons on the touchscreen surface are
>> provided, the overlay-buttons object contains a node for every button
>> and the key event that should be reported when pressed.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  .../bindings/input/touchscreen/touchscreen.yaml    | 152 +++++++++++++++++++++
>>  1 file changed, 152 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> index 895592da9626..d90cbb4932b5 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> @@ -80,6 +80,158 @@ properties:
>>    touchscreen-y-plate-ohms:
>>      description: Resistance of the Y-plate in Ohms
>>  
>> +  overlay-touchscreen:
>> +    description: Clipped touchscreen area
>> +
>> +      This object can be used to describe a frame that restricts the area
>> +      within touch events are reported, ignoring the events that occur outside
>> +      this area. This is of special interest if the touchscreen is shipped
>> +      with a physical overlay on top of it with a frame that hides some part
>> +      of the original touchscreen area.
>> +
>> +      The x-origin and y-origin properties of this object define the offset of
>> +      a new origin from where the touchscreen events are referenced.
>> +      This offset is applied to the events accordingly. The x-size and y-size
>> +      properties define the size of the overlay-touchscreen (effective area).
>> +
>> +      The following example shows the new touchscreen area and the new origin
>> +      (0',0') for the touch events generated by the device.
>> +
>> +                   Touchscreen (full area)
>> +         ┌────────────────────────────────────────┐
>> +         │    ┌───────────────────────────────┐   │
>> +         │    │                               │   │
>> +         │    ├ y-size                        │   │
>> +         │    │                               │   │
>> +         │    │      overlay-touchscreen      │   │
>> +         │    │                               │   │
>> +         │    │                               │   │
>> +         │    │            x-size             │   │
>> +         │   ┌└──────────────┴────────────────┘   │
>> +         │(0',0')                                 │
>> +        ┌└────────────────────────────────────────┘
>> +      (0,0)
>> +
>> +     where (0',0') = (0+x-origin,0+y-origin)
> 
> What happens if touchscreen-inverted-x/y are set?
> 
> Though the existing binding never defines what the non-inverted 
> orientation is.
> 
This feature acts on the raw input values and the inversion is carried
out afterwards.The events will be inverted within the defined frame,
which is probably the expected behavior.

>> +
>> +    type: object
>> +
>> +    properties:
>> +      x-origin:
>> +        description: horizontal origin of the clipped area
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      y-origin:
>> +        description: vertical origin of the clipped area
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      x-size:
>> +        description: horizontal resolution of the clipped area
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      y-size:
>> +        description: vertical resolution of the clipped area
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +        required:
>> +          - x-origin
>> +          - y-origin
>> +          - x-size
>> +          - y-size
>> +
>> +  overlay-buttons:
>> +    description: list of nodes defining the buttons on the touchscreen
>> +
>> +      This object can be used to describe buttons on the touchscreen area,
>> +      reporting the touch events on their surface as key events instead of
>> +      the original touch events.
>> +
>> +      This is of special interest if the touchscreen is shipped with a
>> +      physical overlay on top of it where a number of buttons with some
>> +      predefined functionality are printed. In that case a specific behavior
>> +      is expected from those buttons instead of raw touch events.
>> +
>> +      The overlay-buttons properties define a per-button area as well as an
>> +      origin relative to the real touchscreen origin. Touch events within the
>> +      button area are reported as the key event defined in the linux,code
>> +      property. Given that the key events do not provide coordinates, the
>> +      button origin is only used to place the button area on the touchscreen
>> +      surface. Any event outside the overlay-buttons object is reported as a
>> +      touch event with no coordinate transformation.
>> +
>> +      The following example shows a touchscreen with a single button on it
>> +
>> +              Touchscreen (full area)
>> +        ┌───────────────────────────────────┐
>> +        │                                   │
>> +        │                                   │
>> +        │   ┌─────────┐                     │
>> +        │   │button 0 │                     │
>> +        │   │KEY_POWER│                     │
>> +        │   └─────────┘                     │
>> +        │                                   │
>> +        │                                   │
>> +       ┌└───────────────────────────────────┘
>> +     (0,0)
>> +
>> +      The overlay-buttons object can  be combined with the overlay-touchscreen
>> +      object as shown in the following example. In that case only the events
>> +      within the overlay-touchscreen object are reported as touch events.
>> +
>> +                  Touchscreen (full area)
>> +        ┌─────────┬──────────────────────────────┐
>> +        │         │                              │
>> +        │         │    ┌───────────────────────┐ │
>> +        │ button 0│    │                       │ │
>> +        │KEY_POWER│    │                       │ │
>> +        │         │    │                       │ │
>> +        ├─────────┤    │  overlay-touchscreen  │ │
>> +        │         │    │                       │ │
>> +        │         │    │                       │ │
>> +        │ button 1│    │                       │ │
>> +        │ KEY_INFO│   ┌└───────────────────────┘ │
>> +        │         │(0',0')                       │
>> +       ┌└─────────┴──────────────────────────────┘
>> +     (0,0)
>> +
>> +    type: object
>> +
>> +    patternProperties:
>> +      '^button-':
>> +        type: object
>> +        description:
>> +          Each button (key) is represented as a sub-node.
>> +
>> +        properties:
>> +          label:
>> +            $ref: /schemas/types.yaml#/definitions/string
>> +            description: descriptive name of the button
>> +
>> +          linux,code: true
>> +
>> +          x-origin:
>> +            description: horizontal origin of the button area
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +          y-origin:
>> +            description: vertical origin of the button area
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +          x-size:
>> +            description: horizontal resolution of the button area
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +          y-size:
>> +            description: vertical resolution of the button area
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +        required:
>> +          - linux,code
>> +          - x-origin
>> +          - y-origin
>> +          - x-size
>> +          - y-size
> 
> We have the same properties defined twice. Move all the common ones to a 
> $def entry and then reference it here and in overlay-touchscreen.
> 
> $defs:
>   overlay-node:
>     type: object
>     properties:
>       x-origin:
>       ...
> 
> And then here:
> 
> '^button-':
>   $ref: '#/$defs/overlay-node
>   unevaluatedProperties: false
> 
>   properties:
>     label:
>       ...
> 
> 
> Rob
Thank your for your feedback, I will send a next version with this
modification in it.

Best regards,
Javier Carrasco
