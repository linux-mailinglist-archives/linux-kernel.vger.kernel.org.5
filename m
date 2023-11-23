Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945537F67CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjKWTs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWTs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:48:57 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E59A;
        Thu, 23 Nov 2023 11:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To9oc6eyLTPyVUgrGTITeVixXiZ50rhUBrKQNv8qO3qWSuKac+aBZYPA4KYJ9JAwesW/CujDWNeG3g8G361nsZt4eiL2Q5HQYayYLAPgzYiKDj5zk6E6cy+WwmHwWUBFHjwKj0MlqrvZU646wqtU1Mixq3VccSIOLgWfUrcTfd5dy6B665LPHLQ2JtHdy2TpjOKVE2CsDaoeOQU8pK8uQ9X0f5LkgqL1OFwAJG27hM09tMJjU2eq8iuNUXuuf79NMTQM+q/qQGNudGHlcEpcPlaoT7rx3Kf+VOAO0xP1w+MQ/Vp7s+KGxveN0FdPUp3kl7iVirlWivfq+qK7Bm1hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKOZtYlUR/+s2aDY0HiUC9doRnnwbV5H5YV8XrFSeog=;
 b=EElOQPqs4McyJyzRP9+UaX3OeQJMYm3F4Vd5j3KVEbMHKKOK4F2eEkO+qshLGUwzXeEoBAkJRMV3YjWQcRkmqs7Mk52gvysd9QFfA1pK/ba51Ln7w3dHzBmA+9HgUn+l65By5NUJffmH5BVxllbWGp12q1739cdWbwoVE3P8KDb5YUdX/xaG8fbau632yVkjZ90Ov0Ucoc4tq+2aO7N2LklXSI/G65CsXNFgbtJX/inoQjwcob4CDuygVRxaQdxae2R7HqP+QEq3+e9OpdScN+81ZUGkoSNksADT6x925WbgnrAtoKhahef/Olr2sABhyXSzwEG81k/FhV7hLg9zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKOZtYlUR/+s2aDY0HiUC9doRnnwbV5H5YV8XrFSeog=;
 b=BqOxpk069AvkEWdW/TXelbMFMLATnJ+wEgP0SJfOY1+1AUZKfJpwRSgkRcT4XNuAwYloqRoG8kr/zW18AfdTlEZGrvJQNUU8dcbJB9EvrtCpq6hrpTe5XUsWwK8TlYOC8NNcAC5OakM3RUcp2YfXEBR6L8JUmOICbb9tcNVJtB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAXPR08MB6752.eurprd08.prod.outlook.com (2603:10a6:102:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 19:48:59 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 19:48:59 +0000
Message-ID: <487555fa-72ad-4d1a-ac68-51826f56f1cd@wolfvision.net>
Date:   Thu, 23 Nov 2023 20:48:56 +0100
User-Agent: Mozilla Thunderbird
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [PATCH v5 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
 <ZTp72LUXxr+Z9gn8@nixie71>
Content-Language: en-US
In-Reply-To: <ZTp72LUXxr+Z9gn8@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAXPR08MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d767b74-7349-4981-05bf-08dbec5d3c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpJAJRWkKjOoqvnOltfUY0AvPGeQpMgVZiGnoql3KBWZOlFBWJb/946UMuieiVE6MiqVSU+I5yuSBU1GpE2QxrRBihns83Xqs0M78IL67ZZmhXs1+uF/EtWU5T6vT+JjU8s+DPSqSaj0G6mGNV37tlq4xUm1wa8g1rDk8Crg4ZsEbBa5p/ef1223Letnkv3zFfORlpdEgCNYzUmCpxsddrrGokzBQqWlwGBiBTMRfy71xpeiogdtqjIZNsd2MVqTFPvNDZvtdyz7TWvzlo26nJdzKbLnKKQtatEOX+WLHA3wKdRiaf7K1MxuL65DE9/b58joFwIuveMOVoDNjbGU1rCNlHOp7FTDSffLgmh53/bccLsN94R9Qi5UOmTC5NIikbxV0HgaNyUNSM98m4ijOJwdqqoURLaZCLxnCo9KQEHzscTWHGruf1UBqhTpQgmbCFqCNVd/oWwBZF2hNFbSpQBrC5fXDdE/Di+qLOxM6vyUkJYHtwXpaoDVhd35QGr9mjEur20bSKYnuGKh8Fq+Sdc6mobcoik94ojH3M18LDm/bNC+H7H6lFaP68bVCn0s37AnxF2TyNU2AYJPACSZI0u1K6dEvsZZuvHE1i7tyZM3NG0ZIVh3+mGJpqEWSLSyc6yGrZA5nA+QS3YUpbxu4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39850400004)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(7416002)(86362001)(44832011)(5660300002)(31696002)(31686004)(38100700002)(83380400001)(6666004)(6506007)(54906003)(316002)(53546011)(6512007)(2616005)(4326008)(6916009)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(6486002)(478600001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdlL2FYSVg5YWhqSnpnamk1UnUydkwyakFRbGxzdklJYlliMlZoRU0rZmVH?=
 =?utf-8?B?dm50S0hUK1djOHJQZk9VbTh2WnRodUw5cjZBQnQ1cjhmYk15ZFN1WTR2WXZp?=
 =?utf-8?B?U0Y2amU3YkVURGtnRk5pcEl5bnRmR0ZEL0tPU0NqRUFrZHV1L3c5MUdrK09x?=
 =?utf-8?B?eldkT2VHdkFjZklGQ3M1Y0hqQStHRkVkRC9IQlZKaCswaDBvMUR2dVBXMU9G?=
 =?utf-8?B?RDJPUURwRTdtVW9zSHVncVlxNnhzYldmQVFubGZuMytkUFdkMGNJVy9kdlcy?=
 =?utf-8?B?elFINEcxdllvM3A5ckNzMjcvWTRFZ1QxcWovQVRpZFdaai9maWpKNVZXMUdK?=
 =?utf-8?B?VUxYY2Z1NGZHN2VUKzAzdEhGMnFEU1lVci9YY0Z6bUhiNGhySzIwcCtBU2Jx?=
 =?utf-8?B?a0dSL3dtbGptejQ0cEYyMzEvb0FWZDErR0lwTU13SjJySW03ZEptZUpkbHN6?=
 =?utf-8?B?VHR0MEt3M3pEeWplRXpwZzNaNTlEV0NabENZWW5lU3cwanY4VEVoRnl6R1dl?=
 =?utf-8?B?OUh2ejlGSlVwU0Z1MlhFdU8yV0RJRnh3TFpXaVF2Z0dlc2FiMHFnUC9QbXd6?=
 =?utf-8?B?eXBmSnBjbDR1M3phSGNXUkQrRTdLVEN2OGcvNHgwcGJuTk1EMkZyS2dVb3Mx?=
 =?utf-8?B?RVducnlFcFNlemcrWlkrTWZaSU5FRWtWYmNoa1dwSzFBKzdDZG5vN1R4SjJE?=
 =?utf-8?B?RVAxakQ3NTI1QUc5bzJ2TWtGaVFWcFZUcW03aXdDaUhYaGhOaGhZTFdaSStx?=
 =?utf-8?B?OTZWeFdiU2dhMVZnQVBSZHdETlcvZ096WnBMcjFxcCsvUTJXVkhJeGFWSGJK?=
 =?utf-8?B?YjVmb0RMeHRaRWl6TXZ4cU8zY1AzNlV6NEF3K3NMY0NGYThBaHJRRHhNK3Nk?=
 =?utf-8?B?UnkrWnVLNkg2RFo5dXIzbk1aUG5hZ29yNkg0OWxYOXdQMVBlSGx5dnpnQzZ3?=
 =?utf-8?B?RVlZYUlTYi9sREt2S2w5eGVmSytUWE9iSWE1UWVtUVhiZmNzSlZJL3hjZ2NS?=
 =?utf-8?B?c2RQMk9SZnBHS0lSOWlqUGVpM0tINHNtT1ljN3kzL1B3U2c0N2pQWk5hRnY0?=
 =?utf-8?B?ZnY3REtkN09MeVcxem9kT1Qwdy9peWtHMnJoOWV6R2Q0cmlNdkpLUHB0NDhp?=
 =?utf-8?B?cHZpY3JFdVA5Qmc1ajhoSllsa01VQVNuZXdzSWUwNGhSNnJTTnJsN1F4QXgx?=
 =?utf-8?B?cVpPaDg4b0N1MW4zOG1vNVFaNGJEaEdEZWRDdGxjT05LVW0xYlZTVzh3cFFF?=
 =?utf-8?B?UVFzNGlCSWhTdHJIUnBsZWpzNFY0NlNUS05CV1pYU0QxZUtWUk5MQkNwdk5u?=
 =?utf-8?B?bVJMbmJqRUxNclQrdE9RMWkvOE92RHRzRzVpRnNJT1dUMjhaNFY1amluQnA3?=
 =?utf-8?B?UlYxa2V5TDdEc0VGNXg0M2t5a2VhM0dUcXhxdzh5SktpcEJhNkNQRkVPT0VV?=
 =?utf-8?B?U1pyTVVKYXpkUWNxZXBOMHo1VjRvb21yQ1dyMnd1VkszRWxqMHBraXY5azFH?=
 =?utf-8?B?WTQrSG1wNGJWd29jNDI3bFdCTFIxSFMvWERJZk5McVdBSllKV25tbkwrNk96?=
 =?utf-8?B?aEx0VklQenlqTmNENjAvMUdrTDVzRjNCZzQ0VHRvay9XTU1tSktndGpQdXBs?=
 =?utf-8?B?UmFGY2UreUl4RkZIYW9HcnNIUTVhM01QZlhiYTU5NCsvTXo5ckdBOUJ6QmJF?=
 =?utf-8?B?aDF0VUpwald5YnVVUXJ0N1JjcHJTU24xRURBdUlSdUlsTVA5RzNFaGpKUDJV?=
 =?utf-8?B?WVhaQ1hFNFRPN2pCYW8wUC9udldlZmVTUmlBVkxHQWdIS3pRUW5CbnpUS1p4?=
 =?utf-8?B?QnIvVkRYRU0vVW5maVArdWdnQmNqRERlbk1rcU0xN0Z3WkNTNU5BeUk3Mm5S?=
 =?utf-8?B?RGlpdnBFWGpEakgra3BFMW93alNRSUV2a1ZiUnBPQWJWUzhrcEo1SGMwMmdH?=
 =?utf-8?B?Wi9VKy8xcWZHVDNNRlJZZFJ4ZE1DSEQxQTZYSVRoQzEwR3lXUXFiSzVZbmFv?=
 =?utf-8?B?eERuSWVmTFJlcTRXb1RaN25sUlIxTm82SFpJV2t5N1NmcjF6bTVMOThTTnNP?=
 =?utf-8?B?SjNYcFZyejY1MHE4bitpWjJNWGdsNFlZWStyYXdITGxLNFIvbVRWNHUzaHgr?=
 =?utf-8?B?Z0xrZzh5M2taWnJXVi94anN3djhoRFkyL01DMkZoTVcvTjNPMnVXMDVKVGtY?=
 =?utf-8?B?TW1zcDJVRmR3UkFRcTJNTEVNVmE2L1hYVGpSWEJWc3IxVUMrVVJ5dmFtdWNS?=
 =?utf-8?Q?BcQqnPtB2aP5U7YcKRgtsPIDUrvTRku7Z2F1pDoAe4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d767b74-7349-4981-05bf-08dbec5d3c21
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:48:58.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrpbrlqBP/XM5DhTojugK3Oi2SRJW1WP87soxY7C/vJ/oeG7UYBzKMSgucJwySrWUHET0/zmLsfsZv89vkLyCCsyZ3mcDrUNTOp0HZ+BHnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26.10.23 16:46, Jeff LaBundy wrote:
> Hi Javier,
> 
> Thank you for continuing to drive this high-quality work.
> 
> On Tue, Oct 17, 2023 at 01:00:08PM +0200, Javier Carrasco wrote:
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
>>  .../bindings/input/touchscreen/touchscreen.yaml    | 143 +++++++++++++++++++++
>>  1 file changed, 143 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> index 431c13335c40..5c58eb79ee9a 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
>> @@ -87,6 +87,129 @@ properties:
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
>> +
>> +    type: object
>> +    $ref: '#/$defs/overlay-node'
>> +    unevaluatedProperties: false
>> +
>> +    required:
>> +      - x-origin
>> +      - y-origin
>> +      - x-size
>> +      - y-size
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
> 
> I am still confused why the buttons need to live under an 'overlay-buttons'
> parent node, which seems like an imaginary boundary. In my view, the touch
> surface comprises the following types of rectangular areas:
> 
> 1. A touchscreen, wherein granular coordinates and pressure are reported.
> 2. A momentary button, wherein pressure is quantized into a binary value
>    (press or release), and coordinates are ignored.
> 
> Any contact that falls outside of (1) and (2) is presumed to be part of a
> border or matting, and is hence ignored.
> 
> Areas (1) and (2) exist in the same "plane", so why can they not reside
> under the same parent node? The following seems much more representative
> of the actual hardware we intend to describe in the device tree:
> 
> 	touchscreen {
> 		compatible = "...";
> 		reg = <...>;
> 
> 		/* raw coordinates reported here */
> 		touch-area-1 {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 		};
> 
> 		/* a button */
> 		touch-area-2a {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 			linux,code = <KEY_POWER>;
> 		};
> 
> 		/* another button */
> 		touch-area-2b {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 			linux,code = <KEY_INFO>;
> 		};
> 	};
> 
Now that I am working on the approach you suggested, I see that some
things can get slightly more complicated. I still think that it is worth
a try, but I would like to discuss a couple of points.

The node parsing is not that simple anymore because the touch-area nodes
are only surrounded by the touchscreen node. Theoretically they could be
even be defined with other properties in between. The current approach
only needs to find the overlay-buttons parent and iterate over all the
inner nodes(simply by calling device_get_named_child_node() and
fwnode_for_each_child_node() the parsing is achieved in two lines +
error checking). So maybe even if we opt for the single-object approach,
an overlay node to group all the touch-areas could simplify the parsing.
Or did you have a different approach in mind? Your example would turn
into this one:

	touchscreen {
		compatible = "...";
		reg = <...>;

		touch-overlay {
			/* raw coordinates reported here */
			touch-area-1 {
				x-origin = <...>;
				y-origin = <...>;
				x-size = <...>;
				y-size = <...>;
			};

			/* a button */
			touch-area-2a {
				x-origin = <...>;
				y-origin = <...>;
				x-size = <...>;
				y-size = <...>;
				linux,code = <KEY_POWER>;
			};

			/* another button */
			touch-area-2b {
				x-origin = <...>;
				y-origin = <...>;
				x-size = <...>;
				y-size = <...>;
				linux,code = <KEY_INFO>;
			};
		};
	};
In my opinion it looks cleaner as well because you are defining a
physical object: the overlay.

> With this method, the driver merely stores a list head. The parsing code
> then walks the client device node; for each touch* child encountered, it
> allocates memory for a structure of five members, and adds it to the list.
> 
The button objects do not only store the keycode, but also the slot and
if they are pressed or not. I could allocate memory for these members as
well, but maybe an additional struct with the button-specific members
set to NULL for the touch areas with keycode = KEY_RESERVED would make
sense. I don't know if that's adding too much overhead for two members
though.

> The event handling code then simply iterates through the list and checks
> if the coordinates reported by the hardware fall within each rectangle. If
> so, and the keycode in the list element is equal to KEY_RESERVED (zero),
> we assume the rectangle is of type (1); the coordinates are passed to
> touchscreen_report_pos() and the pressure is reported as well.

There is another case to consider that might make the iteration less
optimal, but I don't think it will be critical.

A button could be defined inside an overlay-touchscreen (no keycode)
area. Given that the other way round (a touchscreen inside a button)
does not make much sense, the buttons have a higher priority.

Let's take your example: imagine that your third area
is a button inside the first one. We have to iterate through the whole
list until we are sure we checked if there are buttons in the given
position, but keeping in mind that the first object already has the
right coordinates to handle the touch event. Your approach even allows
for multiple no-key areas and we do not know if there are buttons when
we iterate (there could be none).
Therefore some iterations could be unnecessary, but this is probably an
edge case that would cost at most a couple of extra iterations compared
to a two-list approach.

I will keep on working on the next version with a single list while we
clarify these points, so maybe we can save an iteration.
> Kind regards,
> Jeff LaBundy

Best regards,
Javier Carrasco
