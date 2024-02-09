Return-Path: <linux-kernel+bounces-60060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F984FF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792451C210AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8821345;
	Fri,  9 Feb 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="TjvO7r1i"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB51B942;
	Fri,  9 Feb 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516128; cv=none; b=VKmWpycFjisxdrTOoaH+FquFe+t3HLPW8SCdXIqXpn2X3JHDMdWPgs4qnjw7HgRJTq1+pQkBMjUqd3+kKhj6H1Hi8Grqxt00ze/r0mTWgJSlxjLqvSUs9qnzpS1BMNHFXA+ngN9Fu8/Id69JgGYiLGgJIGbLJOuNc1hVmypKUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516128; c=relaxed/simple;
	bh=7th+TJi6rh0N89ttiDQIXDMtx3cIBHhIIAXDdnPYs+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tJhUMcG1BG1YmtCirtoNUAng/kreJXyNMjeMsib0zWQLNqkyYztScCVL2rBdQ+4lzKQnpqlCXmChydumzTiu+xn5jQF6Xm2HobutcQQo4nQRC0ha03tzMchUmFI0pTr1D0ANBkzg5XUgS04H2DURv8hk7cYh94Ln5hF45k0gBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=TjvO7r1i; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id A3BF420C81F1;
	Fri,  9 Feb 2024 23:01:55 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=dkim20160331; t=1707516111; x=1709330512;
	 bh=nX9Eh+02vO0eza3liVeUN0mLKi5OJmQ4mTmjp/8D2Yc=; b=TjvO7r1int1g
	ra33S89x0zD/b0EbKpLFiW2dQzpP0TDa0PRm23+Fmv5xxDJN9SL7pvM73/I2jSEa
	xOt0pTvlObC7RU4CeDrokMh+it44FlPIZn4SthWmWGxrSfR08LiWPR1ED1vBiXAt
	15O5U7eiWhjo5zxR0ORR3bmOtYmvBj7p/TqPQ4jdjhqwBxTMDK1J5sL+tXqUgT3a
	jGu3MDIUFE1YS57JxQU/57h7rUY+s1sJZqVFmpX4JwWDvDUNpAS2/UBRHayH6N4K
	aDERZCnju14TJFh/wXd+PohLO0Ig4JNdi+52nwZVTATRXkcjLH/N0ovlYyPQXagG
	IoRhomVPcyR9uswRK/BuCqhNKOStM/uOAso+GiUezN+iTorjEucKeJvkCWpATpiJ
	8uFSEqB3Eqz0DBDpFL2YweS2oUJYtiyRV9bhol1BoyezmB7H0353NDesPxXK0dr2
	YSj9qvhhoNHfFsMtOOHtXfboRPg89/EwbNDN6akz0tLNcDGYltPm/DRSzmKSzkm9
	eyAl4lUyiEqzvy/qS4BBbrr2JrSIRG3yKkd/gscbiOxVG7hYIrwsjL2OUYmoRG9W
	CP3R6XFoUizWR9p9BOVKibTEynYwWKxWXtlGZJsirZWjfryc8TLNiTLJc2lGPZAI
	e+7sLYtyY6OsAyGy4SdYPyVup8nLA9A=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5sWNhdpYXb0O; Fri,  9 Feb 2024 23:01:51 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 40D4020C73F8;
	Fri,  9 Feb 2024 23:01:51 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id EF9BA20C3BD5;
	Fri,  9 Feb 2024 23:01:50 +0100 (CET)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davide Benini <davide.benini@gmail.com>,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT:  add translation for I2C summary and protocol
Date: Fri,  9 Feb 2024 23:01:26 +0100
Message-Id: <20240209220126.28042-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Davide Benini <davide.benini@gmail.com>

This patch adds the italian translation for I2C subsystem summary and
protocol. Plus, a reference in the subsystem-apis page.

Signed-off-by: Davide Benini <davide.benini@gmail.com>
Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/i2c/i2c-protocol.rst   | 99 +++++++++++++++++++
 .../translations/it_IT/i2c/index.rst          | 46 +++++++++
 .../translations/it_IT/i2c/summary.rst        | 64 ++++++++++++
 Documentation/translations/it_IT/index.rst    |  1 +
 .../translations/it_IT/subsystem-apis.rst     | 47 +++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 Documentation/translations/it_IT/i2c/i2c-protocol.rst
 create mode 100644 Documentation/translations/it_IT/i2c/index.rst
 create mode 100644 Documentation/translations/it_IT/i2c/summary.rst
 create mode 100644 Documentation/translations/it_IT/subsystem-apis.rst

diff --git a/Documentation/translations/it_IT/i2c/i2c-protocol.rst b/Documentation/translations/it_IT/i2c/i2c-protocol.rst
new file mode 100644
index 000000000000..ba7c8cd8f560
--- /dev/null
+++ b/Documentation/translations/it_IT/i2c/i2c-protocol.rst
@@ -0,0 +1,99 @@
+=================
+Il protocollo I2C
+=================
+
+Questo documento è una panoramica delle transazioni di base I2C e delle API
+del kernel per eseguirli.
+
+Spiegazione dei simboli
+=======================
+
+=============== ===========================================================
+S               Condizione di avvio
+P               Condizione di stop
+Rd/Wr (1 bit)   Bit di lettura/scrittura. Rd vale 1, Wr vale 0.
+A, NA (1 bit)   Bit di riconoscimento (ACK) e di non riconoscimento (NACK).
+Addr  (7 bit)   Indirizzo I2C a 7 bit. Nota che questo può essere espanso
+                per ottenere un indirizzo I2C a 10 bit.
+Dati  (8 bit)   Un byte di dati.
+
+[..]            Fra parentesi quadre i dati inviati da dispositivi I2C,
+                anziché dal master.
+=============== ===========================================================
+
+
+Transazione semplice di invio
+=============================
+
+Implementato da i2c_master_send()::
+
+  S Addr Wr [A] Dati [A] Dati [A] ... [A] Dati [A] P
+
+
+Transazione semplice di ricezione
+=================================
+
+Implementato da i2c_master_recv()::
+
+  S Addr Rd [A] [Dati] A [Dati] A ... A [Dati] NA P
+
+
+Transazioni combinate
+=====================
+
+Implementato da i2c_transfer().
+
+Sono come le transazioni di cui sopra, ma invece di uno condizione di stop P
+viene inviata una condizione di inizio S e la transazione continua.
+Un esempio di lettura di un byte, seguita da una scrittura di un byte::
+
+  S Addr Rd [A] [Dati] NA S Addr Wr [A] Dati [A] P
+
+
+Transazioni modificate
+======================
+
+Le seguenti modifiche al protocollo I2C possono essere generate
+impostando questi flag per i messaggi I2C. Ad eccezione di I2C_M_NOSTART, sono
+di solito necessari solo per risolvere problemi di un dispositivo:
+
+I2C_M_IGNORE_NAK:
+    Normalmente il messaggio viene interrotto immediatamente se il dispositivo
+    risponde con [NA]. Impostando questo flag, si considera qualsiasi [NA] come
+    [A] e tutto il messaggio viene inviato.
+    Questi messaggi potrebbero comunque non riuscire a raggiungere il timeout
+    SCL basso->alto.
+
+I2C_M_NO_RD_ACK:
+    In un messaggio di lettura, il bit A/NA del master viene saltato.
+
+I2C_M_NOSTART:
+    In una transazione combinata, potrebbe non essere generato alcun
+    "S Addr Wr/Rd [A]".
+    Ad esempio, impostando I2C_M_NOSTART sul secondo messaggio parziale
+    genera qualcosa del tipo::
+
+      S Addr Rd [A] [Dati] NA Dati [A] P
+
+    Se si imposta il flag I2C_M_NOSTART per il primo messaggio parziale,
+    non viene generato Addr, ma si genera la condizione di avvio S.
+    Questo probabilmente confonderà tutti gli altri dispositivi sul bus, quindi
+    meglio non usarlo.
+
+    Questo viene spesso utilizzato per raccogliere le trasmissioni da più
+    buffer di dati presenti nella memoria di sistema in qualcosa che appare
+    come un singolo trasferimento verso il dispositivo I2C. Inoltre, alcuni
+    dispositivi particolari lo utilizzano anche tra i cambi di direzione.
+
+I2C_M_REV_DIR_ADDR:
+    Questo inverte il flag Rd/Wr. Cioè, se si vuole scrivere, ma si ha bisogno
+    di emettere una Rd invece di una Wr, o viceversa, si può impostare questo
+    flag.
+    Per esempio::
+
+      S Addr Rd [A] Dati [A] Dati [A] ... [A] Dati [A] P
+
+I2C_M_STOP:
+    Forza una condizione di stop (P) dopo il messaggio. Alcuni protocolli
+    simili a I2C come SCCB lo richiedono. Normalmente, non si vuole essere
+    interrotti tra i messaggi di un trasferimento.
diff --git a/Documentation/translations/it_IT/i2c/index.rst b/Documentation/translations/it_IT/i2c/index.rst
new file mode 100644
index 000000000000..14fbe3d78299
--- /dev/null
+++ b/Documentation/translations/it_IT/i2c/index.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Il sottosistema I2C/SMBus
+=========================
+
+Introduzione
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   summary
+   i2c-protocol
+
+Scrivere un device driver
+=========================
+
+.. toctree::
+   :maxdepth: 1
+
+Debugging
+=========
+
+.. toctree::
+   :maxdepth: 1
+
+Slave I2C
+=========
+
+.. toctree::
+   :maxdepth: 1
+
+
+Argomenti avanzati
+==================
+
+.. toctree::
+   :maxdepth: 1
+
+.. only::  subproject and html
+
+   Indici
+   ======
+
+   * :ref:`genindex`
diff --git a/Documentation/translations/it_IT/i2c/summary.rst b/Documentation/translations/it_IT/i2c/summary.rst
new file mode 100644
index 000000000000..1535e13a32e2
--- /dev/null
+++ b/Documentation/translations/it_IT/i2c/summary.rst
@@ -0,0 +1,64 @@
+==========================
+Introduzione a I2C e SMBus
+==========================
+
+I²C (letteralmente "I al quadrato C" e scritto I2C nella documentazione del
+kernel) è un protocollo sviluppato da Philips. É un protocollo lento a 2 fili
+(a velocità variabile, al massimo 400KHz), con un'estensione per le velocità
+elevate (3.4 MHz). Questo protocollo offre un bus a basso costo per collegare
+dispositivi di vario genere a cui si accede sporadicamente e utilizzando
+poca banda. Alcuni sistemi usano varianti che non rispettano i requisiti
+originali, per cui non sono indicati come I2C, ma hanno nomi diversi, per
+esempio TWI (Interfaccia a due fili), IIC.
+
+L'ultima specifica ufficiale I2C è la `"Specifica I2C-bus e manuale utente"
+(UM10204) <https://www.nxp.com/webapp/Download?colCode=UM10204>`_
+pubblicata da NXP Semiconductors. Tuttavia, è necessario effettuare il login
+al sito per accedere al PDF. Una versione precedente della specifica
+(revisione 6) è archiviata
+`qui <https://web.archive.org/web/20210813122132/
+https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_.
+
+SMBus (Bus per la gestione del sistema) si basa sul protocollo I2C ed è
+principalmente un sottoinsieme di protocolli e segnali I2C. Molti dispositivi
+I2C funzioneranno su SMBus, ma alcuni protocolli SMBus aggiungono semantica
+oltre quanto richiesto da I2C. Le moderne schede madri dei PC si affidano a
+SMBus. I più comuni dispositivi collegati tramite SMBus sono moduli RAM
+configurati utilizzando EEPROM I2C, e circuiti integrati di monitoraggio
+hardware.
+
+Poiché SMBus è principalmente un sottoinsieme del bus I2C,
+possiamo farne uso su molti sistemi I2C. Ci sono però sistemi che non
+soddisfano i vincoli elettrici sia di SMBus che di I2C; e altri che non possono
+implementare tutta la semantica o messaggi comuni del protocollo SMBus.
+
+
+Terminologia
+============
+
+Utilizzando la terminologia della documentazione ufficiale, il bus I2C connette
+uno o più circuiti integrati *master* e uno o più circuiti integrati *slave*.
+
+.. kernel-figure::  ../../../i2c/i2c_bus.svg
+   :alt:    Un semplice bus I2C con un master e 3 slave
+
+   Un semplice Bus I2C
+
+Un circuito integrato  **master** è un nodo che inizia le comunicazioni con gli
+slave. Nell'implementazione del kernel Linux è chiamato **adattatore** o bus. I
+driver degli adattatori si trovano nella sottocartella ``drivers/i2c/busses/``.
+
+Un **algoritmo** contiene codice generico che può essere utilizzato per
+implementare una intera classe di adattatori I2C. Ciascun driver dell'
+adattatore specifico dipende da un driver dell'algoritmo nella sottocartella
+``drivers/i2c/algos/`` o include la propria implementazione.
+
+Un circuito integrato **slave** è un nodo che risponde alle comunicazioni
+quando indirizzato dal master. In Linux è chiamato **client** (dispositivo). I
+driver dei dispositivi sono contenuti in una cartella specifica per la
+funzionalità che forniscono, ad esempio ``drivers/media/gpio/`` per espansori
+GPIO e ``drivers/media/i2c/`` per circuiti integrati relativi ai video.
+
+Per la configurazione di esempio in figura, avrai bisogno di un driver per il
+tuo adattatore I2C e driver per i tuoi dispositivi I2C (solitamente un driver
+per ciascuno dispositivo).
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index 51a15bf37577..70ccd23b2cde 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -92,6 +92,7 @@ interfacciarsi con il resto del kernel.
 
    core-api/index
    Sincronizzazione nel kernel <locking/index>
+   subsystem-apis
 
 Strumenti e processi per lo sviluppo
 ====================================
diff --git a/Documentation/translations/it_IT/subsystem-apis.rst b/Documentation/translations/it_IT/subsystem-apis.rst
new file mode 100644
index 000000000000..d179af60c26d
--- /dev/null
+++ b/Documentation/translations/it_IT/subsystem-apis.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+Documentazione dei sottosistemi del kernel
+==========================================
+
+In questa parte della documentazione si entra nel dettaglio di come funzionano
+i sottosistemi specifici del kernel dal punto di vista di uno sviluppatore del
+kernel. Molte delle informazioni qui contenute provengono direttamente dai
+sorgenti del kernel, con aggiunte di materiale dove è necessario (anche se
+talora *non* è stato aggiunto tutto ciò che era necessario).
+
+Sottosistemi principali
+-----------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+
+Interfacce uomo-macchina
+------------------------
+
+.. toctree::
+   :maxdepth: 1
+
+
+Interfacce di rete
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+Interfacce per l'archiviazione
+------------------------------
+
+.. toctree::
+   :maxdepth: 1
+
+
+Interfacce varie
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   i2c/index
-- 
2.39.2


