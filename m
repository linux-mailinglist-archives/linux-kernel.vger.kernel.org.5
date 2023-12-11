Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332480BFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjLKDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:12:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D8A2;
        Sun, 10 Dec 2023 19:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9MH54zZ24NpFiUvNyrmmAsNztlY2az7R7ZRdNP6xD0dxGj1XkzKGLpIqHy+wZ2sgUesPMNfsu2Zg4Hj7AAWhWufHVTsAtuc7POPMWxW1Zkka+6dmNJ/u4nvpyP+W1xJYC44pZGAsRzK8pejLA2PdyKsBEhC7kH/eodfMhN1y3vsFrhFqXyEV4Xn/XyOW1BBGDYIPqv/dS+7E9tlkfe2qhF7HSagsTkhqIpZhI4wNFDDbUCwQ2qO8XG6BEsT33Itk0WGrGftbmZgTJGivcLTcd2fImhWdc0TqeASwSslCNTlad7wF2laqeUTdA8EcR9uY/7lOb7HVVjqtfGYMydoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIOaei/5JYm0PBJh/tfPV9qwQDIRzAez/8hPFWxzC0k=;
 b=EYHSrEKEX+uwHWw1XuHHo/WpgLKmkSZIK9MrAcLI1BdkA4Yw0m6pGiOa/by5jwOzsu7Y8Jp1pqOKhJYGI1k+sHMTZl+jPFe1/o2sH+VZqRLuumd09p03A6hYckWLudEuz/snkXmDZNsHr+6Bu9AaCQp6xCfUr3l/0BYRvWThYVSZtQjtmrys13Nye88OLOFreRsJW9Xj+Evjp2eZbBng+3fSGADwgOBycNqqHdYJfNjeFSFJpbLoHn0kJd0zKfgZyr+5MzjRgdm+3j5zlT74onXINfGi4CCDVJ7NS7iCj4Vxe29maKoemKFEaEzlRx/8VKcszt+JfW6pIsRfM6uoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIOaei/5JYm0PBJh/tfPV9qwQDIRzAez/8hPFWxzC0k=;
 b=Pe02AeAb2xphCE7Uq1srf97LCk/cQ+xRb80Q5lS08HP4D8gVNY0/hOBJgSge9wydr+7neGkSZ6jnvJpJEgpbipgKeM1PD7eUC5X8k01gP3oyu9GbHn3wR7IPJ6G0vnDKPaPtt564nyoMj3JlsDWAmQAiEd6aHE0dIaYbzAfSwGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 03:12:05 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 03:12:05 +0000
Message-ID: <c2ce0112-b8c8-4e68-ae6a-488bc99e0dc3@amd.com>
Date:   Sun, 10 Dec 2023 21:12:02 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] docs/sp_SP: Add translation of process/management-style
Content-Language: en-US
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
        linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20231122003343.931394-1-avadhut.naik@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231122003343.931394-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be1db08-fe76-4052-5281-08dbf9f6f3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Po0zWdthlW7ZYmlRfqiCKPMtippmlb4WTZKXwiL8MqiT9DrmFSly15rzT3QWW85CeYHamE22KCgP6Fy9eGElf63oPyknaG/L/3GFz63QhVzYTRmJsk3Uh+JEj25RZuCjwx9KlYne6QG6Xi4u31WcC10cBan9x2ShnSxzrh/U634OkUKf0IGaGY88dKobsEbOW15+OXmgBTad3HDHcoLm56VgCHv0n4cdamYx+JPvrPAgojH2YA10x5S+GwexlnsETiT3c1XbxG9R23rtJINbDbiHLreDCFvHrl5bMt5pEDcaT8OI1m4Oh9qwaPYlVfgWuWhCLckBsfXiA+D8FkLEr910pD/ZcuQBPNDrF16PsRZPQNQuC4b0fzap3gDTiNPogP1j9RN3EBAAp9PYUFEMaVNcrZUKIpKPzvJTIXf9luCaeo6kxLqiyjp01/3BJhl3uv+SqUINSZEFJOKMProRAJVS7DtGhekfUNC63l/jku8tUf/mp0trxKlxlMEknMEU5rhGRl+NX9OH/UcV8MR/++FH6Rmcg/BNS+qVVn533zRXWu7nfvs7bGF/aqUl7+WeuPvbImdzCs1WrLmxVafzdhE2zP3ycwAn4FHNGRABmNnn0oVyE5mBcEhH5MZ3yZHForiN8Fa+nXLjxM/K+5buW7LKeoaji2AKVxwE5LNlBd+D79AOPBITr6FeIQBP6XlsfurVcPVQULB7jSGbGcPo/uRTPOWENQByZPgmDESszH1oqVo5hdJwcQMl+wH5vJ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230473577357003)(230373577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(2616005)(66574015)(6506007)(6666004)(6512007)(53546011)(83380400001)(5660300002)(30864003)(41300700001)(2906002)(4326008)(478600001)(966005)(6486002)(8676002)(8936002)(66946007)(66556008)(316002)(6916009)(66476007)(31696002)(38100700002)(36756003)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5odGx5MTRXWThJL0tpenMvRGNuNEZJeFNUaUlsVnBhQW5ZT09Vbnd1VEp4?=
 =?utf-8?B?SUw1ZHZXOWRUZGhwaHlRaGs2STIvaklkSGhYTENCOEZjek9XVXVXbUpPSFlN?=
 =?utf-8?B?ZGdhYzhYSjM3TXRWOXNiVW93M1J1bUhrVExjeW1YZDVveHZqM3BiYjdUU2Vn?=
 =?utf-8?B?dzh0OGF3YkIrTlBVUysyV2JFMDZnNk1tYmVyQ2tKQisxK0VPRmFCTS9NV3Vs?=
 =?utf-8?B?d2lYbmlNaXZuV0tIZG9TbmlSU1hoczdsUXlIYnlOSmtYTElyaWJ6TW1HOER4?=
 =?utf-8?B?SFRTbVA5UW52eGJ5cDl5UEVrbXBoSDlvQTBaOXRXN0lmSzU4RndnekY2a3U4?=
 =?utf-8?B?dkhTVTR2TkVzRTVZcUhjWWJRekhadnU2REtyL1htN0tiMVgxT01vMFlWMWtV?=
 =?utf-8?B?eVdrR0xTWWpIREE2eUhGRUUwRy92NVBXamNNWjFieG9HeGNvWmtDbytDTVZ1?=
 =?utf-8?B?eTZRbUJDdys5RDE5SGN1Z2E5Riswb3VvSmYxY3diSk81UFZOVzM0WUtBV2I5?=
 =?utf-8?B?TC8zaWJmS2g4MlpIR0pzWWVkeHZqcGdMTjNxV3g2dEVvNEUxYkVabzV3QVBH?=
 =?utf-8?B?THVPc1NidVFabnIwRTEvaW1xK3hoQk5WU05aZHNxeGsya2Ivb2JmVjBKbjI4?=
 =?utf-8?B?K3FSUVlFS1p3V0FIdFNrVlh5WklJZm9mRnZVcGwzclhvTVk0bGwzY0NBZTFG?=
 =?utf-8?B?Wk1POUkvbUdoeDZkZEhNMldoZU9HakMxZzVPM2hnR21TRTBmN01vNXAvZ3dt?=
 =?utf-8?B?dUJmdmxjYStheWtXb2JLRXlWbC8xUjRnY28xQWJoeEJvRzBRQ2twck8yU1VB?=
 =?utf-8?B?OVFEcTNyYkJMbW9uMno5QWtoTGZ1RSsvT2duS3h0MlZQRGNmMk5EaW1lQnR6?=
 =?utf-8?B?T0xaRXlaMnJxWjZoUmNtR21FVzRTdWJzVWRIM0ZBeU1LREs5Zkx5RXpvbTBP?=
 =?utf-8?B?ZFJYUzhUN3Erbm02aUd0RExrakhVb3NPeHFmbVp3YzF2M0xpdmJZTDM4czJ5?=
 =?utf-8?B?WmgwbHIxcnl4Y2NJTkNvTXQxMUwrZCtGMVlXUjlyQnErOCszTUNFRTlEbHF5?=
 =?utf-8?B?ajJTckNpWGkrczhtejlsOHpmcU85dVNPaWJ5a3JCMXNKWTFaK0VKYTRtUzAv?=
 =?utf-8?B?bVdobUpZVVFwWG9BckZscG5vQkxkRW1VZDllamtsQkpHUld1UGpFcVNxVGFO?=
 =?utf-8?B?TVlDL3NOQ1RXUGpzOG1wWDdUc2JsdEFqejlaQ1pFcFFYUkdQSi8wNWU3Vi9p?=
 =?utf-8?B?dVpkYkg5Y0NNUndXM3Z5TXQwSG9wRVFwaGJSQThMWElyL3dSNTRuZG9Xcmp4?=
 =?utf-8?B?eE1RMk5zMlBFNVF0M29TbWhGQ3lkUEZmK2ZLSzdBemxiUE1lWStFZTl3bnZi?=
 =?utf-8?B?eTZoK285ZWROdDMxSVFmaVFRU2pUdldoQktWMTZLUU4xUk1aK3RRS0JES3Bn?=
 =?utf-8?B?U0VuR2NBQ3J5aUhMTG44VVhYUGs0LzZSMmN2K2lIb1liRm5DWVdiNG5KWVNn?=
 =?utf-8?B?RUkra1pVdmxjTm5vWHdwS0RZRkNUN2hFVHlmMFhHeXBzSTJYMXlPV1MwSlUx?=
 =?utf-8?B?dXNWMThBZk5wcHhMSGN4aFV6OGU2aVBxaUlSSWgwMU1pYnEwd0NHRHpJTUJJ?=
 =?utf-8?B?WlpyL2JkYVp5QnlIRHRwS1B5MTZSNndTNTlPY2JZNjZxTHlMR1pDUTUxRzZn?=
 =?utf-8?B?TkhhaEhmbFA1NytLRGdHV1A0MWhpcm9DK3dTNDBxZldvaGN6YkY4TDQraVpz?=
 =?utf-8?B?ci80cVFGWjJmaTA3WUd1Rk1ZdnRkWXVQMFlpQkFHUHQ3cEJVR0h0di85S1VT?=
 =?utf-8?B?K01MQ0hHYnNSc1VWRW5RZDJVQ2xNaXloWWNmNEpyd2Y4MDdVZ09SLzNTbHE5?=
 =?utf-8?B?QklyekJwY2grSnJQTWo1S2Npd0NnM3FZYWpwYldQamxFd3VYdTZUV29uR3ZB?=
 =?utf-8?B?dTQyTUVVekt3MDU3bDllZHhPM2VUc2hkNjFBaVA3YkJYRGxYdE90TTc5Vzc3?=
 =?utf-8?B?Nnp2dkNEam5JWmFwTGE4Y3d5Q3Z6R3c1THA2bjBjVlQvMDNrbmpqeDNiNERN?=
 =?utf-8?B?ZUdCckxHc2JCdUlMQ0NWa1pEM3NrSkQ0UlFseS8zUm5KQlNCNGdSK2hCakhx?=
 =?utf-8?Q?CXTiDbO2pd96Zz8lVwFzHUWww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be1db08-fe76-4052-5281-08dbf9f6f3c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 03:12:05.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D95ClPum0zloxH89f6Pe3KmopWvjSPJ5HCrnCu4w2MWKMcTZ7z0yneNH4WWAOzy/RQeFPHR+fjZXm1ewe9Ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this standalone patch. Have incorporated it in the below patchset since no
feedback was received on it and since patches 2 and 4 in the set below had a dependency on it.

https://lore.kernel.org/linux-doc/20231211023730.2026204-1-avadhut.naik@amd.com/T/#t

Thanks,
Avadhut Naik.

On 11/21/2023 18:33, Avadhut Naik wrote:
> Translate Documentation/process/management-style.rst into Spanish.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../sp_SP/process/management-style.rst        | 299 ++++++++++++++++++
>  2 files changed, 300 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/management-style.rst
> 
> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
> index a082e162168a..2c6eda05ba7a 100644
> --- a/Documentation/translations/sp_SP/process/index.rst
> +++ b/Documentation/translations/sp_SP/process/index.rst
> @@ -25,3 +25,4 @@
>     security-bugs
>     embargoed-hardware-issues
>     handling-regressions
> +   management-style
> diff --git a/Documentation/translations/sp_SP/process/management-style.rst b/Documentation/translations/sp_SP/process/management-style.rst
> new file mode 100644
> index 000000000000..4db33fbf8941
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/process/management-style.rst
> @@ -0,0 +1,299 @@
> +.. include:: ../disclaimer-sp.rst
> +
> +:Original: Documentation/process/management-style.rst
> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
> +
> +.. _sp_managementstyle:
> +
> +
> +Estilo de gestión del kernel de Linux
> +=====================================
> +
> +Este es un documento breve que describe el estilo de gestión preferido (o
> +inventado, dependiendo de a quién le preguntes) para el kernel de Linux.
> +Está destinado a reflejar el documento
> +:ref:`translations/sp_SP/process/coding-style.rst <sp_codingstyle>` hasta
> +cierto punto y está escrito principalmente para evitar responder a [#f1]_
> +las mismas preguntas (o similares) una y otra vez.
> +
> +El estilo de gestión es muy personal y mucho más difícil de cuantificar
> +que reglas simples de estilo de codificación, por lo que este documento
> +puede o no tener relación con la realidad. Comenzó como una broma, pero
> +eso no significa que no pueda ser realmente cierto. Tendrás que decidir
> +por ti mismo.
> +
> +Por cierto, cuando se hable de “gerente de kernel”, se refiere a las
> +personas lideres técnicas, no de las personas que hacen la gestión
> +tradicional dentro de las empresas. Si firmas pedidos de compra o tienes
> +alguna idea sobre el presupuesto de tu grupo, es casi seguro que no eres
> +un gerente de kernel. Estas sugerencias pueden o no aplicarse a usted.
> +
> +En primer lugar, sugeriría comprar “Seven Habits of Highly Effective
> +People” y NO leerlo. Quemarlo, es un gran gesto simbólico.
> +
> +.. [#f1] Este documento lo hace no tanto respondiendo a la pregunta, sino
> +  haciendo dolorosamente obvio para el interrogador que no tenemos ni idea
> +  de cuál es la respuesta.
> +
> +De todos modos, aquí va:
> +
> +.. _decisiones:
> +
> +1) Decisiones
> +-------------
> +
> +Todos piensan que los gerentes toman decisiones, y que la toma de
> +decisiones en importante. Cuanto más grande y dolorosa sea la decisión,
> +más grande debe ser el gerente para tomarla. Eso es muy profundo y obvio,
> +pero en realidad no es cierto.
> +
> +El nombre del partido es **evitar** tener que tomar una decisión. En
> +particular, si alguien te dice “elige (a) o (b), realmente necesitamos
> +que decidas sobre esto”, estas en problemas como gerente. Es mejor que
> +las personas a las que diriges conozcan los detalles mejor que tú, así
> +que, si acuden a ti para tomar una decisión técnica, estas jodido.
> +Claramente no eres competente para tomar una decisión por ellos.
> +
> +(Corolario: Si las personas a las que diriges no conocen los detalles
> +mejor que tú, también estas jodido, aunque por una razón totalmente
> +diferente. Es decir, que estas en el trabajo equivocado y que **ellos**
> +deberían gestionando tu brillantez en su lugar).
> +
> +Así que el nombre del partido es **evitar** las decisiones, al menos las
> +grandes y dolorosas. Tomar decisiones pequeñas y sin consecuencias está
> +bien, y te hace parecer que sabes lo que estás haciendo, así que lo que
> +un gerente de kernel necesita hacer es convertir las decisiones grandes
> +y dolorosas en cosas pequeñas a los que a nadie realmente le importa.
> +
> +Ayuda darse cuenta de que la diferencia clave entre una decisión grande
> +y una pequeña es si puede arreglar su decisión después. Cualquier
> +decisión se puede hacer pequeña simplemente asegurándose siempre de que
> +si te equivocaste (u **estarás** equivocado), siempre puede deshacer el
> +daño más tarde retrocediendo. De repente, llegas a ser doblemente
> +gerencial por tomar **dos** decisiones intrascendentes - la equivocada
> +**y** la correcta.
> +
> +Y las personas incluso verán eso como un verdadero liderazgo (*tos*
> +mierda *tos*).
> +
> +Por lo tanto, la llave para evitar las grandes decisiones se convierte en
> +simplemente evitar hacer cosas que no se pueden deshacer. No te dejes
> +llevar a una esquina del que no puedas escapar. Una rata acorralada puede
> +ser peligrosa – un gerente acorralado es directamente lamentable.
> +
> +Resulta que, dado que nadie sería tan estúpido como para dejar que un
> +gerente de kernel tenga una gran responsabilidad **de todos modos**,
> +generalmente es bastante fácil retroceder. Dado que no vas a poder
> +malgastar grandes cantidades de dinero que tal vez no puedas pagar, lo
> +único que puedes revertir es una decisión técnica, y ahí retroceder es
> +muy fácil: simplemente diles a todos que fuiste un bobo incompetente,
> +pide disculpas y deshaz todo el trabajo inútil que hiciste trabajar a la
> +gente durante el año pasado. De repente, la decisión que tomaste hace un
> +año no era una gran decisión después de todo, ya que se podía deshacer
> +fácilmente.
> +
> +Resulta que algunas personas tienen problemas con este enfoque, por dos
> +razones:
> +
> + - admitir que eras un idiota es más difícil de lo que parece. A todos
> +   nos gusta mantener las apariencias, y salir en público a decir que te
> +   equivocaste a veces es muy duro.
> + - que alguien te diga que lo que trabajaste durante el último año no
> +   valió la pena después de todo también puede ser duro para los pobres
> +   ingenieros humildes, y aunque el **trabajo** real fue bastante fácil
> +   de deshacer simplemente eliminándolo, es posible que hayas perdido
> +   irrevocablemente la confianza de ese ingeniero. Y recuerda:
> +   “irrevocablemente” fue lo que tratamos de evitar en primer lugar, y
> +   tu decisión terminó siendo muy grande después de todo.
> +
> +Afortunadamente, estas dos razones pueden mitigarse eficazmente
> +simplemente admitiendo inicialmente que no tienes ni idea, y diciéndole
> +a la gente que tu decisión es puramente preliminar, y podría ser la cosa
> +equivocada. Siempre te debes reservar el derecho de cambiar de opinión, y
> +hacer que la gente sea muy **consciente** de eso. Y es mucho más fácil
> +admitir que eres estúpido cuando **aun** no has hecho la cosa realmente
> +estúpida.
> +
> +Entonces, cuando realmente resulta ser estúpido, la gente simplemente
> +pone los ojos y dice “Ups, otra vez no”.
> +
> +Esta admisión preventiva de incompetencia también podría hacer que las
> +personas que realmente hacen el trabajo piensen dos veces sobre si vale la
> +pena hacerlo o no. Después de todo, si **ellos** no están seguros de si es
> +una buena idea, seguro que no deberías alentarlos prometiéndoles que lo
> +que trabajan será incluido. Haz que al menos lo piensen dos veces antes de
> +embarcarse en un gran esfuerzo.
> +
> +Recuerda: Es mejor que sepan más sobre los detalles que tú, y
> +generalmente ya piensan que tienen la respuesta a todo. Lo mejor que puede
> +hacer como gerente no es inculcar confianza, sino más bien una dosis
> +saludable de pensamiento crítico sobre lo que hacen.
> +
> +Por cierto, otra forma de evitar una decisión es quejarse lastimeramente
> +de “no podemos hacer ambas cosas?” y parecer lamentable. Créeme, funciona.
> +Si no está claro cuál enfoque es mejor, lo descubrirán. La respuesta puede
> +terminar siendo que ambos equipos se sientan tan frustrados por la
> +situación que simplemente se den por vencidos.
> +
> +Eso puede sonar como un fracaso, pero generalmente es una señal de que
> +había algo mal con ambos proyectos, y la razón por la que las personas
> +involucradas no pudieron decidir fue que ambos estaban equivocados.
> +Terminas oliendo a rosas y evitaste otra decisión que podrías haber
> +metido la pata.
> +
> +2) Gente
> +--------
> +
> +La mayoría de las personas son idiotas, y ser gerente significa que
> +tendrás que lidiar con eso, y quizás lo más importante, que **ellos**
> +tienen que lidiar **contigo**.
> +
> +Resulta que, si bien es fácil deshacer los errores técnicos, no es tan
> +fácil deshacer los trastornos de personalidad. Solo tienes que vivir
> +con los suyos - y el tuyo.
> +
> +Sin embargo, para prepararse como gerente del kernel, es mejor recordar
> +no quemar ningún puente, bombardear a ningún aldeano inocente o alienar
> +a demasiados desarrolladores del kernel. Resulta que alienar a las
> +personas es bastante fácil, y desalienarlas es difícil. Por lo tanto,
> +“alienar” cae inmediatamente debajo del título “no reversible”, y se
> +convierte en un no-no según :ref:`decisiones`.
> +
> +Aquí solo hay algunas reglas simples:
> +
> + (1) No llames a la gente pen*ejos (al menos no en público)
> + (2) Aprende a disculparte cuando olvidaste la regla (1)
> +
> +El problema con #1 es que es muy fácil de hacer, ya que puedes decir
> +“eres un pen*ejo” de millones de manera diferentes [#f2]_, a veces sin
> +siquiera darte cuenta, y casi siempre con una convicción ardiente de que
> +tienes razón.
> +
> +Y cuanto más convencido estés de que tienes razón (y seamos sinceros,
> +puedes llamar a casi **cualquiera** un pen*ejo, y a menudo **tendrás**
> +razón), más difícil termina siendo disculparse después.
> +
> +Para resolver este problema, realmente solo tienes dos opciones:
> +
> + - Se muy buenos en las disculpas.
> + - Difunde el “amor” de manera tan uniforme que nadie termina sintiendo
> +   que es atacado injustamente. Hazlo lo suficientemente ingenioso, e
> +   incluso podría divertirse.
> +
> +La opción de ser infaliblemente educado realmente no existe. Nadie
> +confiará en alguien que está ocultando tan claramente su verdadero
> +carácter.
> +
> +.. [#f2] Paul Simon cantó “Cincuenta maneras de dejar a tu amante” porque,
> +  francamente, “Un millón de maneras de decirle a un desarrollador que es
> +  un pen*ejo” no escanea tan bien. Pero estoy seguro de que lo pensó.
> +
> +3) Gente II – el Buen Tipo
> +--------------------------
> +
> +Aunque resulta que la mayoría de las personas son idiotas, el corolario
> +de eso es, tristemente, que tú también seas uno, y aunque todos podemos
> +disfrutar del conocimiento seguro de que somos mejores que la persona
> +promedio (somos realistas, nadie cree que nunca que son promedio o debajo
> +del promedio), también debemos admitir que no somos el cuchillo más
> +afilado alrededor, y habrá otras personas que son menos idiotas que tú.
> +
> +Algunas personas reaccionan mal a las personas inteligentes. Otras se
> +aprovechan de ellos.
> +
> +Asegúrate de que tú, como mantenedor del kernel, estás en el segundo
> +grupo. Aguanta con ellos, porque son las personas que te facilitarán el
> +trabajo. En particular, podrán tomar tus decisiones por ti, que es de lo
> +que se trata el juego.
> +
> +Así que cuando encuentras a alguien más inteligente que tú, simplemente
> +sigue adelante. Sus responsabilidades de gestión se convierten en gran
> +medida en las de decir “Suena como una buena idea, - hazlo sin
> +restricciones”, o “Eso suena bien, pero ¿qué pasa con xxx?". La segunda
> +versión en particular es una excelente manera de aprender algo nuevo
> +sobre “xxx” o parecer **extra** gerencial al señalar algo que la persona
> +más inteligente no había pensado. En cualquier caso, sales ganando.
> +
> +Una cosa para tener en cuenta es darse cuenta de que la grandeza en un
> +área no necesariamente se traduce en otras áreas. Así que puedes impulsar
> +a la gente en direcciones específicas, pero seamos realistas, pueden ser
> +buenos en lo que hacen, y ser malos en todo lo demás. La buena noticia es
> +que las personas tienden a gravitar naturalmente hacia lo que son buenos,
> +por lo que no es como si estuvieras haciendo algo irreversible cuando los
> +impulsas en alguna dirección, simplemente no presiones demasiado.
> +
> +4) Colocar la culpa
> +-------------------
> +
> +Las cosas saldrán mal, y la gente quiere culpar a alguien. Etiqueta, tú
> +lo eres.
> +
> +En realidad, no es tan difícil aceptar la culpa, especialmente si la gente
> +se da cuenta de que no fue **toda** tu culpa. Lo que nos lleva a la mejor
> +manera de asumir la culpa: hacerlo por otra persona. Te sentirás bien por
> +asumir la caída, ellos se sentirán bien por no ser culpados, y la persona
> +que perdió toda su colección de pornografía de 36 GB debido a tu
> +incompetencia admitirá a regañadientes que al menos intentaste escapar
> +de ella.
> +
> +Luego haz que el desarrollador que realmente metió la pata (si puedes
> +encontrarlo) sepa **en privado** que metió la pata. No solo para que
> +pueda evitarlo en futuro, sino para que sepan que te deben uno. Y, quizás
> +aún más importante, también es probable que sea la persona que puede
> +solucionarlo. Porque, seamos sinceros, seguro que no eres tú.
> +
> +Asumir la culpa también es la razón por la que llegas a ser un gerente
> +en primer lugar. Es parte de lo que hace que la gente confíe en ti y te
> +permita la gloria potencial porque eres tú quien puede decir “metí la
> +pata”. Y si has seguido las reglas anteriores, ya serás bastante bueno
> +para decir eso.
> +
> +5) Cosas que evitar
> +-------------------
> +
> +Hay una cosa que la gente odia incluso más que ser llamado “pen*ejo”,
> +y que es ser llamado “pen*ejo” en una voz mojigata. Por lo primero,
> +puedes disculparte, por lo segundo, realmente, no tendrás la oportunidad.
> +Es probable que ya no estén escuchando, incluso si de lo contrario haces
> +un buen trabajo.
> +
> +Todos pensamos que somos mejores que los demás, lo que significa que
> +cuando alguien más se da aires, **realmente** nos molesta. Puedes ser
> +moral e intelectualmente superior a todos los que te rodean, pero no
> +trates de hacerlo demasiado obvio a menos que tengas **la intención**
> +real de irritar a alguien [#f3]_.
> +
> +Del mismo modo, no seas demasiado educado o sutil acerca de las cosas. La
> +cortesía fácilmente termina yendo demasiado lejos y ocultado el problema,
> +y como dicen “En internet, nadie puede oírte ser sutil”. Usa un gran
> +objeto contundente para enfatizar el punto, porque realmente no puedes
> +depender de que las personas entiendan tu punto de otra manera.
> +
> +Un poco de humor puede ayudar a suavizar tanto la franqueza como la
> +moralización. Exagerar hasta el punto de ser ridículo puede reforzar un
> +punto sin hacer que sea doloroso para el destinatario, quien simplemente
> +piensa que estas siendo tonto. Por lo tanto, puede ayudarnos a superar el
> +bloqueo mental personal que todos tenemos sobre la crítica.
> +
> +.. [#f3] La pista: Los grupos de noticias de Internet que no están
> +  directamente relacionados con tu trabajo son excelentes maneras de
> +  desahogar tus frustraciones con otras personas. Escribe mensajes
> +  insultantes con una mueca de desprecio solo para entrar en un humor de
> +  vez en cuando, y te sentirás limpio. Eso sí, no te cagues demasiado
> +  cerca de casa.
> +
> +6) ¿Por qué a mí?
> +-----------------
> +
> +Dado que tu principal responsabilidad parece ser asumir la culpa de los
> +errores de otras personas y hacer dolorosamente obvio para todos los
> +demás que eres incompetente, la pregunta obvia es: ¿por qué hacerlo en
> +primer lugar?
> +
> +Pase lo que pase, **tendrás** una sensación inmensa de logro personal por
> +estar “a cargo”. No importa el hecho de que realmente estés liderando al
> +tratar de mantenerte al día con todos los demás y correr detrás de ellos
> +lo más rápido que puedes. Todo el mundo seguirá pensando que eres la
> +persona a cargo.
> +
> +Es un gran trabajo si puedes descifrarlo.
